{ pkgs, ... }:
{
  home.packages = [ pkgs.hyprland ];

  home.file.".config/hypr" = {
    source = ../../.config/hypr;
    recursive = true;
  };
}
