# Ansible Role: Rime Configuration

This role deploys a personal Rime input method configuration to various operating systems. It handles placing the configuration files in the correct location for each supported platform (`macOS`, `Gentoo`, `Arch Linux`, etc.).

This role is designed to be managed via `ansible-galaxy` by including it in a `requirements.yml` file.
Requirements

This role assumes that the Rime input method engine (such as `fcitx5-rime` on Linux) is already installed on the target system. This role only manages the configuration files, not the installation of the application itself.

## Role Variables

The role uses a variables file (`vars/main.yml`) to determine the correct destination path for the Rime configuration based on the target operating system. These variables are not typically meant to be overridden by the user.

The core variable structure is found in `vars/main.yml`:

```yaml
# vars/main.yml
# Defines the Rime configuration directory path for different OS families
rime_destination_paths:
  Linux: "{{ ansible_env.HOME }}/.local/share/fcitx5/rime"
  Darwin: "{{ ansible_env.HOME }}/Library/Rime"
  Windows: "{{ ansible_env.HOME }}/AppData/Roaming/Rime"
```

## Dependencies

This role has no external Ansible role dependencies.

## Example Playbook

To use this role, you first need to install it via `ansible-galaxy`:

```yaml
# requirements.yml
roles:
- name: rime
    src: git+<https://github.com/centsent/ansible-role-rime.git>
    version: main
```

```bash
ansible-galaxy install -r requirements.yml
```

Then, you can include it in your playbook. Since the role is part of a larger `dotfiles` setup, it's best called via a meta-role or tagged dependency. Here is how it would be structured within a main `dotfiles` project:

`roles/common/meta/main.yml`:

```yaml
---
dependencies:
# ... other roles
- role: rime
    tags: rime
```

`playbook.yml`:
You can then run the role on its own by using tags.

```bash
ansible-playbook -i your_inventory playbook.yml --tags "rime"
```

The role's `tasks/main.yml` will then use Ansible facts to determine the correct symlink location for the host it's running on:

```yaml
YAML
# tasks/main.yml
---
- name: Include OS-specific variables
  ansible.builtin.include_vars: vars/main.yml

- name: Symlink Rime config for Unix-like systems (Linux, macOS)
  ansible.builtin.file:
    src: "{{ role_path }}/files/rime"
    dest: "{{ rime_destination_paths[ansible_system] }}"
    state: link
    force: true
    follow: false
  when: ansible_system in ['Linux', 'Darwin']

- name: Symlink Rime config for Windows
  ansible.windows.win_file:
    src: "{{ role_path }}/files/rime"
    dest: "{{ rime_destination_paths[ansible_os_family] }}"
    state: junction
  when: ansible_system == "Windows"
```
