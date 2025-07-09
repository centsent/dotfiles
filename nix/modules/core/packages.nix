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
    rm-improved
    sops
    tokei
    wakatime-cli
    xcp
  ];
}
