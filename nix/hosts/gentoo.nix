{ pkgs, ... }:

{
  home.username = "gentty";
  home.homeDirectory = "/home/gentty";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/rime
    ../modules/apps/linux-apps.nix
  ];

  home.stateVersion = "25.05";
}
