{ username, ... }:
{
  home.username = username;
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [
    ../modules/core
    ../modules/dev
    ../modules/apps
    ../modules/rime
  ];
}
