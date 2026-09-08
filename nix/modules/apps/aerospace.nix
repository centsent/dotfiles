{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.aerospace ];

  xdg.configFile."aerospace" = {
    source = "${flake}/.config/aerospace";
    recursive = true;
  };
}
