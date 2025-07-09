{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.waybar ];

  home.file.".config/waybar" = {
    source = "${flake}/.config/waybar";
  };
}
