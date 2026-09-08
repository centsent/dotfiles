{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.waybar ];

  xdg.configFile."waybar" = {
    source = "${flake}/.config/waybar";
  };
}
