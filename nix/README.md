# Nix / home-manager

User-level configuration: packages, dotfiles and application settings. System
provisioning (bootloader, portage, services) lives in `../ansible`.

## Usage

```bash
# From this directory. The host name selects the configuration.
home-manager switch --flake .#gentoo    # Linux workstation; initial bootstrap: make home in ../
home-manager switch --flake .#macosx    # macOS laptop

nix fmt .                               # format
nix fmt -- --check .                    # what CI checks
nix flake update                        # refresh flake.lock
```

To check a configuration evaluates without activating it:

```bash
nix eval --raw .#homeConfigurations.gentoo.activationPackage.drvPath
```

`nix flake check` verifies the external source hashes. The regression suite
explicitly evaluates both `homeConfigurations`, which are not standard flake
check outputs. Neither operation activates a home generation.

The Intel Mac remains on Nixpkgs 26.05, the final release supporting
`x86_64-darwin`. The flake explicitly sets `allowDeprecatedx86_64Darwin` for
that platform, including the bootstrap CLI and formatter. This acknowledges the
warning; it does not extend upstream support, which ends in late 2026. See the
[Nixpkgs release notes](https://nixos.org/manual/nixpkgs/unstable/release-notes#x86_64-darwin-26.05)
before upgrading the macOS inputs beyond 26.05.

## Layout

```
nix/
├── flake.nix          # Entrypoint: inputs, formatter, homeConfigurations.
├── flake.lock         # Pins every input. Committed on purpose.
├── sources.nix        # Commit revisions and hashes for external dotfile sources.
│
├── hosts/             # One file per machine; picks which modules apply.
│   ├── common.nix     # Shared modules and Home Manager CLI.
│   ├── gentoo.nix     # user gentty, x86_64-linux
│   └── macosx.nix     # user theodo, x86_64-darwin
│
├── modules/
│   ├── core/          # Applied everywhere: packages, shell, git, fonts,
│   │                  # environment variables, zsh aliases.
│   ├── dev/           # Language toolchains and mise.
│   ├── apps/          # Application configuration.
│   │   ├── default.nix      # Cross-platform apps (terminals, tmux, yazi…).
│   │   ├── linux-apps.nix   # Hyprland, waybar, swaync, wlogout, flameshot.
│   │   └── macos-apps.nix   # AeroSpace and macOS-only packages.
│   └── rime/          # Input method, large enough to warrant its own module.
│
└── .config/           # Verbatim dotfiles, pulled in by home.file / xdg.configFile
    ├── hypr/          # Hyprland, configured in Lua.
    ├── nvim/          # LazyVim setup.
    ├── waybar/, swaync/, wlogout/, rime/, doom/, mise/
    └── alacritty/, kitty/, ghostty/, aerospace/
```

Modules that need to reference `.config/` receive the flake root as a `flake`
special argument (see `extraSpecialArgs` in `flake.nix`), e.g.
`source = "${flake}/.config/hypr"`.
Application configuration normally uses `xdg.configFile`; `home.file` is reserved
for non-XDG destinations such as Rime and `.ideavimrc`.

## Ownership and updates

| Resource | Owner | Update command |
|---|---|---|
| User packages and most dotfiles | Home Manager | `make home` from the repository root |
| Neovim configuration and writable LazyVim lockfile | Ansible repository symlink | `make neovim` |
| Doom checkout and writable configuration link | Ansible | `make doom-emacs` |
| Mise executable and shell integration | Home Manager | Update `flake.lock`, then `make home` |
| Global language toolchain versions | `.config/mise/config.toml` | Edit exact versions, then `dotfiles-tools-sync` |
| Tmux theme and local configuration | Home Manager | Update `sources.nix`, then `make home` |
| Tmux plugins | TPM | Use the explicit install/update bindings in `.config/.tmux.conf.local` |

Home activation does not run Mise installation or Doom synchronization. Use
`dotfiles-tools-sync` after applying toolchain changes, `dotfiles-doom-sync --install`
on first use, and `dotfiles-doom-sync` for later Doom changes. Shell integration
uses the Nix-installed Mise, so an old `~/.local/bin/mise` does not override it.
The toolchain pins match the workstation versions recorded during the refactor;
Mise backend implementations and downloaded tools are outside `flake.lock`.
Home Manager owns the entire `~/.config/mise` directory, preserving the symlink
layout of older generations so upgrades do not collide with a file inside the
read-only Nix store. `make home` also backs up unmanaged file conflicts using a
timestamp suffix; it never force-overwrites them or an existing backup.

TPM is the sole Tmux plugin manager. Automatic plugin updates on launch and reload
are disabled. Editor and TPM plugin state remains outside the Nix package lock.
The editor links depend on this checkout remaining in place.

To update an external source in `sources.nix`, choose a commit revision, calculate
its unpacked SHA-256, update both fields, then run `nix flake check`. Avoid branch
names: an unchanged configuration should fetch the same source on a new machine.

## Shell helpers

`aic` asks `agy` to commit all staged, unstaged, and untracked changes in one
Conventional Commit. `aim` asks it to group the changes into separate commits;
it requires an empty index, so commit or unstage existing staged changes first.
Both helpers use the Git worktree root, preserve your current directory, forward
additional arguments to `agy`, and instruct it not to push.

Use `rip`, `xcp`, `bat`, and `procs` by name. The standard `rm`, `cp`, `cat`, and
`ps` names retain their normal behavior, and `gh` uses the Nix-installed GitHub CLI.
The on-demand npm commands in `modules/core/zsh-aliases.nix` pin their top-level
package versions; their transitive npm dependencies are not locked by `flake.lock`.
Update those pins explicitly when upgrading the tools.

Run the Git helper regression tests without launching an agent:

```bash
nix shell --inputs-from . nixpkgs#python3 nixpkgs#zsh nixpkgs#git \
  --command python3 -m unittest discover -s tests -v
```

## Adding a module

1. Create `modules/<area>/<name>.nix`.
2. Import it from that area's `default.nix`, or from `linux-apps.nix` /
   `macos-apps.nix` if it is platform-specific.
3. Run `nix fmt .` and evaluate the affected host.
