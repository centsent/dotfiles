{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  imports = [
    ../modules/core
  ];

  home.stateVersion = "24.05";
}
