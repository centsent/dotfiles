{ pkgs, ... }:

{
  imports = [
    ./desktop-entries.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
