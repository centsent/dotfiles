{ username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/apps/linux-apps.nix
    ../modules/rime
  ];

  home.stateVersion = "25.05";
}
