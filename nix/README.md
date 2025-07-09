```
nix/
├── flake.nix             # The main entrypoint, orchestrates everything.
├── flake.lock            # Automatically generated, pins dependencies. MUST be in Git.
├── README.md
├── .gitignore
|
├── hosts/                # Top-level configurations for each specific machine.
│   ├── macbook.nix
│   └── gentoo-desktop.nix
|
├── modules/              # Reusable modules defining sets of functionality.
│   ├── core/             # Core shell setup, git, essential tools.
│   │   ├── git.nix
│   │   ├── shell.nix     # (zsh, starship, etc.)
│   │   └── default.nix   # Imports all modules in this directory.
│   │
│   ├── apps/             # GUI and terminal applications.
│   │   ├── alacritty.nix
│   │   ├── beekeeper.nix
│   │   └── default.nix
│   │
│   ├── dev/              # Development environments.
│   │   ├── asdf.nix
│   │   ├── neovim.nix
│   │   └── default.nix
│   │
│   └── rime/             # A complex configuration broken into its own module.
│       └── default.nix
|
└── pkgs/                 # For any custom packages you might create.
    └── default.nix

```
