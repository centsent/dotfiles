{ pkgs, flake, ... }:
{
  home.packages = [ pkgs.hyprland ];

  home.file.".config/hypr" = {
    source = "${flake}/.config/hypr";
    recursive = true;
  };
}
