{ pkgs, ... }:

{
  imports = [
    ./aerospace.nix
  ];

  home.packages = with pkgs; [
    iina
    pika
    raycast
    shottr
  ];
}
