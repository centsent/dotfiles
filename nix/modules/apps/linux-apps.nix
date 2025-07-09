{ pkgs, ... }:

{
  imports = [
    ./desktop-entries.nix
    ./flatpak.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
