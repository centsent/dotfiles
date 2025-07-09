{ pkgs, flake, ... }:
{
  home.packages = [ pkgs.aerospace ];

  home.file.".config/aerospace" = {
    source = "${flake}/.config/aerospace";
    recursive = true;
  };
}
