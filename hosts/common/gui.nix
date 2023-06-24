{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    hack-font
    jetbrains-mono
    nerdfonts
    postman
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
}
