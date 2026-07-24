# My Personal Dotfiles

My personal `dotfiles` and workstation setup, covering macOS and Gentoo. The
goal is a fully automated, idempotent, version-controlled environment.

The repository has two halves, and both are needed to bring up a machine:

| | Tool | Scope |
|---|---|---|
| [`ansible/`](ansible) | [Ansible](https://www.ansible.com/) | System provisioning: bootloader, portage, system packages, services, display manager |
| [`nix/`](nix) | [home-manager](https://github.com/nix-community/home-manager) | User environment: dotfiles, user packages, application configuration |

Ansible installs Nix itself, then home-manager takes over everything inside
`$HOME`. See [`nix/README.md`](nix/README.md) for the home-manager side.

## Features

- **Platforms**: macOS and Gentoo.
- **Shell**: Zsh, Starship, Zoxide.
- **Terminals**: Alacritty, Kitty, Ghostty.
- **Window Managers**: Hyprland (Linux), AeroSpace (macOS).
- **Editors**: Neovim (LazyVim), Doom Emacs, VS Code, IntelliJ IDEA.
- **Tools**: Git, Tmux, Nix, Topgrade, Flatpak, Yazi.
- **Input Methods**: Rime.
- **Networking**: dae (Gentoo), configured from SOPS-encrypted secrets.

## Prerequisites

- `git`, `make`, `python` (Ansible runs on Python).
- `sops` and an age/SSH key listed in [`.sops.yaml`](.sops.yaml), if you need to
  read or edit the encrypted secrets.

## Installation and Usage

The `Makefile` detects the host OS (macOS or Gentoo) and selects the matching
Ansible inventory. If it cannot identify the host it fails with a message
rather than guessing.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/centsent/dotfiles.git
   cd dotfiles
   ```

2. **Provision the system:**

   ```bash
   make gentoo   # or: make macos
   ```

3. **Apply the user environment:**

   ```bash
   cd nix
   home-manager switch --flake .#gentoo    # or .#macosx
   ```

### Specific Targets

Any target name that is not a defined rule is passed through to Ansible as a
tag, which gives per-role control:

```bash
make grub       # only the grub tasks
make greetd     # only the greetd tasks
make flatpak    # only the flatpak tasks
```

Other targets:

```bash
make install                       # both playbooks
make edit                          # open the SOPS-encrypted secrets
make INVENTORY_FILE=hosts_gentoo …  # override host detection
```

## Project Structure Overview

### Ansible

- `*.yml`: Top-level playbooks (`dotfiles.yml`, `macos.yml`, `gentoo.yml`)
  defining the high-level execution flow.
- `hosts_*`: Inventory file per environment (`hosts_macos`, `hosts_gentoo`),
  selected automatically by the Makefile.
- `group_vars/`: Variables per inventory group — e.g. `group_vars/macos` holds
  the Homebrew package list, `group_vars/all/secrets.sops.yaml` the encrypted
  secrets.
- `roles/`:
  - `macos` / `gentoo`: meta-roles listing the dependencies for each OS.
  - Application roles (`greetd`, `grub`, `portage`, `dae`, …): self-contained,
    one concern each.

### CI

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) runs on every push:
yamllint, ansible-lint and `--syntax-check` over the Ansible tree; `nix fmt
--check`, `nix flake check` and an explicit evaluation of both
`homeConfigurations`; and a check that the secrets file is actually encrypted.

## License

[MIT](LICENSE)
