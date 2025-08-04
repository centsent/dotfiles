{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.yazi ];

  home.file.".config/yazi" = { source = "${flake}/.config/yazi"; };
}
