{ config, ... }:

{
  sops = {
    defaultSopsFile = ../../../ansible/group_vars/all/secrets.sops.yaml;
    age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

    secrets.tailscale_ssh_config.path = "${config.home.homeDirectory}/.ssh/config";
  };
}
