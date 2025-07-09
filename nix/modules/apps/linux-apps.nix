{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
