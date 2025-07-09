{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
  ];
}
