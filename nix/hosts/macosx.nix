{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/apps/macos-apps.nix
    ../modules/rime
  ];

  home.stateVersion = "25.05";
}
