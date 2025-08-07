{ pkgs, ... }:

{
  home.packages = with pkgs; [ swww resvg ];

  imports = [
    ./desktop-entries.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
