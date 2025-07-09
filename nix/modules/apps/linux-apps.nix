{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
