{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/apps/aerospace.nix
  ];

  home.stateVersion = "24.05";
}
