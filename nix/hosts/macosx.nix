{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/apps/aerospace.nix
    ../modules/apps/macos-apps.nix
  ];

  home.stateVersion = "25.05";
}
