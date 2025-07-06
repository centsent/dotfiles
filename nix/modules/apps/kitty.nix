{ pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];

  home.file.".config/kitty" = {
    source = ../../.config/kitty;
    recursive = true;
  };
}
