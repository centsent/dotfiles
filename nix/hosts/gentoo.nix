{ flake, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  imports = [
    "${flake}/modules/core"
    "${flake}/modules/dev"
    "${flake}/modules/apps"
    "${flake}/modules/rime"
    "${flake}/modules/apps/linux-apps.nix"
  ];

  home.stateVersion = "25.05";
}
