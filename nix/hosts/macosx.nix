{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  imports = [
    ../modules/core
    ../modules/dev
  ];

  home.stateVersion = "24.05";
}
