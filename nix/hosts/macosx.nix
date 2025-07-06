{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/apps/aerospace.nix
    ../modules/apps/macos-apps.nix
  ];

  home.stateVersion = "25.05";
}
