# Nix / home-manager

User-level configuration: packages, dotfiles and application settings. System
provisioning (bootloader, portage, services) lives in `../ansible`.

## Usage

```bash
# From this directory. The host name selects the configuration.
home-manager switch --flake .#gentoo    # Linux workstation
home-manager switch --flake .#macosx    # macOS laptop

nix fmt .                               # format
nix fmt -- --check .                    # what CI checks
nix flake update                        # refresh flake.lock
```

To check a configuration evaluates without activating it:

```bash
nix eval --raw .#homeConfigurations.gentoo.activationPackage.drvPath
```

Note that `nix flake check` does *not* cover `homeConfigurations`, since that
is not a standard flake output — the command above is what CI runs instead.

## Layout

```
nix/
├── flake.nix          # Entrypoint: inputs, formatter, homeConfigurations.
├── flake.lock         # Pins every input. Committed on purpose.
│
├── hosts/             # One file per machine; picks which modules apply.
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

## Adding a module

1. Create `modules/<area>/<name>.nix`.
2. Import it from that area's `default.nix`, or from `linux-apps.nix` /
   `macos-apps.nix` if it is platform-specific.
3. Run `nix fmt .` and evaluate the affected host.
