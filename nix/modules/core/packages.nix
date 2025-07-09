{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    bat
    btop
    eza
    fd
    fzf
    glow
    jq
    lazygit
    ripgrep
    sops
    tokei
    wakatime-cli
  ];
}
