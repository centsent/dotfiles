{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.wofi ];

  home.file.".config/wofi" = {
    source = "${flake}/.config/wofi";
  };
}
