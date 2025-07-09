{ pkgs, flake, ... }:
{
  home.packages = [ pkgs.alacritty ];

  home.file.".config/alacritty" = {
    source = "${flake}/.config/alacritty";
    recursive = true;
  };
}
