{ config, pkgs, ... }: {
  imports = [
    ./cli.nix
    ./gui.nix
  ];
}
