# This module manages all custom font installations.
{ pkgs, ... }:

{
  home.fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "FiraCode" "JetBrainsMono" ]; })

    noto-fonts-cjk-sans
    noto-fonts-cjk-serif

    font-awesome
  ];
}
