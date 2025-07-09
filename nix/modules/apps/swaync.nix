{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.swaync ];

  home.file.".config/swaync" = {
    source = "${flake}/.config/swaync";
  };
}
