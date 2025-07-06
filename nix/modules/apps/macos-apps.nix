{ pkgs, ... }:

{
  home.packages = with pkgs; [
    iina
    pika
    raycast
    shottr
  ];
}
