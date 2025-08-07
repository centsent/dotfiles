{ pkgs, ... }:

{
  imports = [ ./aerospace.nix ];

  home.packages = with pkgs; [ cocoapods iina pika raycast shottr ];
}
