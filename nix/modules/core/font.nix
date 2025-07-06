# This module manages all custom font installations.
{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono

    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    font-awesome
  ];
}
