# Ansible Role: Neovim

This role deploys a personal, [LazyVim](https://www.lazyvim.org/)-based Neovim configuration by symlinking the entire configuration directory.

It is designed to be self-contained and easily managed via `ansible-galaxy` and a `requirements.yml` file. The role simply links the configuration found in the `files/nvim` directory to the user's `~/.config/nvim`.

## Requirements

- Neovim: A modern version of Neovim should be installed on the target machine.
- Git: Required by the Neovim configuration itself (`lazy.nvim`) to clone and manage plugins.

## Role Variables

This role currently has no variables. The configuration is static and fully contained within the `files/nvim` directory.

## Dependencies

This role has no external Ansible role dependencies.

## Example Playbook

To use this role, you should first add it to your project's `requirements.yml` file.

`requirements.yml`:

```yaml
---
roles:
  - name: neovim
    src: git+https://github.com/centsent/ansible-role-neovim.git
    version: main
```

Then, install the role using `ansible-galaxy`:

```bash
ansible-galaxy install -r requirements.yml
```

Finally, you can include the role in your playbook, typically as a dependency of a "common" or "development" role, and control its execution with tags.

Example `roles/common/meta/main.yml`:

```yaml
---
dependencies:
  # ... other roles
  - role: neovim
    tags: neovim
```

The role's task is simple and straightforward:

`tasks/main.yml`:

```yaml
---
- name: Symlink nvim config directory to ~/.config/nvim
  ansible.builtin.file:
    src: "{{ role_path }}/files/nvim"
    dest: "{{ ansible_env.HOME }}/.config/nvim"
    state: link
    force: true
```

You can then run the role on its own by using tags:

```bash
ansible-playbook -i your_inventory playbook.yml --tags "neovim"
```
