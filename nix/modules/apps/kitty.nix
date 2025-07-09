{ pkgs, flake, ... }:
{
  home.packages = [ pkgs.kitty ];

  home.file.".config/kitty" = {
    source = "${flake}/.config/kitty";
    recursive = true;
  };
}
