{ pkgs, ... }:

{
  home.packages = with pkgs; [ awww resvg ];

  imports = [
    ./desktop-entries.nix
    ./flameshot.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
  ];
}
