{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    air
    bat
    btop
    debugpy
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
    yazi
  ];
}
