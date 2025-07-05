{ pkgs, ... }:

{
  home.username = "theodo";
  home.homeDirectory = "/Users/theodo";

  home.packages = with pkgs; [
    git
  ];

  home.stateVersion = "24.05";
}
