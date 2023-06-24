{ config, pkgs, ... }: {
  imports = [../common/default.nix];

  home.packages = with pkgs; [
    jetbrains.idea-community
    obsidian
  ];
}
