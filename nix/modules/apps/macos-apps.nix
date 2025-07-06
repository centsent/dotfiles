{ pkgs, ... }:

{
  home.casks = with pkgs; [
    flux-app
    iina
    orbstack
    pika
    raycast
    shottr
  ];
}
