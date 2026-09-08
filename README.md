# My Personal Dotfiles

My personal `dotfiles` and workstation setup, covering macOS and Gentoo. The
goal is a fully automated, idempotent, version-controlled environment.

The repository has two halves, and both are needed to bring up a machine:

| | Tool | Scope |
|---|---|---|
| [`ansible/`](ansible) | [Ansible](https://www.ansible.com/) | System provisioning: bootloader, portage, system packages, services, display manager |
| [`nix/`](nix) | [home-manager](https://github.com/nix-community/home-manager) | User environment: dotfiles, user packages, application configuration |

Ansible installs Nix itself; Home Manager manages user packages and most
configuration. Ansible keeps the Neovim and Doom configuration linked directly
to this checkout so editor updates can write their state and lockfiles. See
[`nix/README.md`](nix/README.md) for ownership and update commands.

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

- `git`, `make`, and Python 3.13 with `venv` and `pip`.
- Administrator access for system provisioning.
- `sops` and an age/SSH key listed in [`.sops.yaml`](.sops.yaml) for Gentoo
  secrets and Home Manager's SSH configuration.

## Installation and Usage

```bash
git clone https://github.com/centsent/dotfiles.git
cd dotfiles
make setup       # isolated Ansible tools and pinned Galaxy collections
make bootstrap   # system provisioning, then Home Manager; also the default: make
```

`make setup` installs tools in `.venv/` and collections in `.ansible/collections/`.
The Makefile explicitly selects `ansible/ansible.cfg` and detects macOS or Gentoo.
Unknown hosts fail; use `INVENTORY_FILE=hosts_gentoo` to select an inventory.
The first Home Manager switch uses the CLI pinned by `nix/flake.lock`, including
when Nix was just installed and is not yet on the invoking shell's PATH.
`make home` backs up conflicting unmanaged files beside their originals with a
UTC timestamp suffix (`.backup-YYYYMMDDTHHMMSSZ`). Set `HOME_MANAGER_BACKUP_EXT`
to choose another suffix; existing backups are never overwritten. The project's
Nix wrapper hides dirty-tree notices because applying uncommitted edits is expected.
Fresh Nix installs use the multi-user daemon on both supported platforms. The
installer version and checksum are pinned in the Nix installer role's defaults;
existing Nix installations are retained.

Start a new shell after the initial bootstrap to load the user environment.
Toolchain downloads and Doom initialization are explicit follow-up commands:

```bash
dotfiles-tools-sync          # install the pinned global Mise toolchains
dotfiles-doom-sync --install # initialize Doom on first use
dotfiles-doom-sync           # synchronize Doom after later configuration changes
```

### Individual operations

```bash
make install       # system provisioning for the detected inventory
make gentoo        # Gentoo system provisioning
make macos         # macOS system provisioning
make home          # apply the user environment
make grub          # any other target selects an Ansible tag
make nix_flakes    # configure flakes and the required user directories
make edit          # edit SOPS-encrypted secrets
make test          # behavior tests using temporary files; requires Nix
make check         # tests, syntax, lint, formatting, evaluation and source hashes
```

`ANSIBLE_ARGS` can override the default `--ask-become-pass`, for example
`make grub ANSIBLE_ARGS='--check --diff --ask-become-pass'`.
For a custom inventory, also set `HOME_CONFIGURATION` for `make home`.
`install` and tag targets select the matching OS playbook for the built-in
inventories. Set `PLAYBOOK` to override it for a custom inventory.

### Storage migration

Storage migration is excluded from normal provisioning. Run it explicitly:

```bash
make migrate_storage ANSIBLE_ARGS='--check --ask-become-pass'
make migrate_storage
```

Shut down all VMs first. The migration checks image contents with checksums,
retains the original VM directory as `images.pre-migration`, and restores
libvirt's previous running/stopped state even if copying fails. A failed link
switch restores the original directory where possible. Resolve an existing
`.pre-migration` backup before retrying; remove it manually only after validating
the migrated VMs. Use a dedicated destination directory for VM storage. Existing
destination images are preserved; checksum differences stop the migration so
conflicts or interrupted copies can be resolved without overwriting either copy.

The old Portage cache is copied without removing originals or overwriting
existing destination files. Portage alone manages `DISTDIR` in `make.conf`, using
`ansible/group_vars/gentoo/storage.yml`; the migration does not edit that file.

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

### CI and dependency updates

[CI](.github/workflows/ci.yml) lints Ansible, syntax-checks both inventories and
the migration playbook, and tests bootstrap ordering, tag execution, repeat-run
convergence, manifest ordering, checksum verification and migration rollback in
temporary directories. Nix checks evaluate both hosts, exercise shell helpers,
verify activation contains no toolchain/editor download commands, and fetch all
pinned external sources to verify their hashes.

The workflow's manual `build_homes` option also builds complete generations on
Linux and Intel macOS without activating them. Full builds are optional because
the workstation package sets are large. Tests do not run system services or
provision the CI runner.

Python dependencies are locked in `requirements-dev.txt`; edit
`requirements-dev.in` and regenerate with:

```bash
uv pip compile --universal --python-version 3.13 requirements-dev.in -o requirements-dev.txt
make setup
```

Galaxy collection versions live in `ansible/requirements.yml`. Update them
explicitly and run `make check`.

## License

[MIT](LICENSE)
