{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.wlogout ];

  xdg.configFile."wlogout" = {
    source = "${flake}/.config/wlogout";
  };
}
