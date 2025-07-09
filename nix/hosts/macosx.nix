{ pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/Users/${username}";

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
