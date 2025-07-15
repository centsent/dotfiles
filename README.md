# My Personal Dotfiles

This repository contains my personal `dotfiles` and workstation setup, managed entirely by [Ansible](https://www.ansible.com/). The goal is to create a fully automated, idempotent, and version-controlled environment that can be deployed on my machines, which currently include macOS, Gentoo, and Arch Linux (for WSL).

This project goes beyond simple `dotfile` symlinking and handles full system provisioning, including:

- System package installation (via `Homebrew`, `Portage`, `Pacman`, `Nix`).
- Application configuration.
- Development environment setup (via `Nix`).
- System updates and maintenance tasks.

## Features

This Ansible setup manages the configuration for the following platforms and applications:

- **Platforms**: macOS, Gentoo, and Arch Linux.
- **Shell**: Zsh, Oh My Zsh, Starship, Zoxide.
- **Terminal**: Alacritty, Kitty.
- **Window Managers**: Hyprland (Linux), AeroSpace (macOS).
- **Editors**: Neovim (with a custom LazyVim setup), VS Code, IntelliJ IDEA.
- **Tools**: Git, Tmux, Nix, Topgrade, Flatpak.
- **Input Methods**: Rime (managed as an external role).

## Prerequisites

Before running the playbooks, ensure the following are installed on the target machine:

- `git`: To clone this repository.
- `make`: To use the convenient command shortcuts.
- `python`: Ansible runs on Python.

## Installation and Usage

The `Makefile` provides a simple, intelligent interface for setting up a machine. It will automatically detect the host operating system (macOS, Gentoo, or Arch Linux) and use the correct Ansible inventory file.

1. **Clone the repository:**

   ```bash
   git clone https://github.com/centsent/dotfiles.git
   cd dotfiles
   ```

2. **Run the playbooks:**

   ```bash
   make gentoo # Or make macos
   ```

### Specific Targets

The Makefile also provides targets for managing specific parts of the configuration or for running maintenance tasks.

- **Run a platform-specific setup:**

  ```bash
  # Set up a Gentoo machine
  make gentoo

  # Set up a macOS machine
  make macos

  # Set up an Arch Linux machine
  make archlinux
  ```

- **Run a specific role using tags:**
  The Makefile is configured to pass any target name as a tag to Ansible. This allows for granular control.

  ```bash
  # Only run the grub configuration tasks
  make grub

  # Only run the greetd configuration tasks
  make greetd
  ```

## Project Structure Overview

### Ansible

The project follows Ansible best practices to ensure modularity and separation of concerns.

- `*.yml`: Top-level playbooks (`dotfiles.yml`, `macos.yml`, `gentoo.yml`, etc.) that define the high-level execution flow.
- `hosts_*`: Separate inventory files for each environment (`hosts_macos`, `hosts_gentoo`, `hosts_archlinux`). The Makefile automatically selects the correct one.
- `group_vars/`: Contains variables that apply to specific groups defined in the inventory files (e.g., `group_vars/macos` holds the list of Homebrew packages).
- `roles/`: Contains all the Ansible roles.
  - `macos`/`gentoo`/`archlinux`: Meta-roles that define the dependencies for each specific OS.
  - Application-specific roles (`greetd`, `grub`, etc.): Self-contained roles for managing a single application.
- `.github/workflows/`: Contains CI pipeline configurations using GitHub Actions to automatically lint and test the Ansible code.

## License

[MIT](https://www.google.com/search?q=LICENSE)
