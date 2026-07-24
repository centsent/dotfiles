{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.wlogout ];

  home.file.".config/wlogout" = {
    source = "${flake}/.config/wlogout";
  };
}
