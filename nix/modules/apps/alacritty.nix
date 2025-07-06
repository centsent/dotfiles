{ pkgs, ... }:
{
  home.packages = [ pkgs.alacritty ];

  home.file.".config/alacritty" = {
    source = ../../.config/alacritty;
    recursive = true;
  };
}
