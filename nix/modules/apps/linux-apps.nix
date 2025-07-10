{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  imports = [
    ./desktop-entries.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];
}
