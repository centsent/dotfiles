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
  ];

  home.stateVersion = "25.05";
}
