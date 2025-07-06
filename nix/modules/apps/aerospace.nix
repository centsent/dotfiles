{ pkgs, ... }:
{
  home.packages = [ pkgs.aerospace ];

  home.file.".config/aerospace" = {
    source = ../../.config/aerospace;
    recursive = true;
  };
}
