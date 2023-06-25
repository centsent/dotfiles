{ config, pkgs, ... }: {
  imports = [../common/default.nix];

  home.packages = with pkgs; [
  ];
}
