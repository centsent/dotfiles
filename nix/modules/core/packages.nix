{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    air
    bat
    btop
    eza
    fd
    fzf
    gdu
    glow
    gzip
    jq
    lazygit
    ripgrep
    rm-improved
    procs
    sops
    tokei
    wakatime-cli
    xcp
    zellij
  ];
}
