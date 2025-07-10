{ pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    bat
    btop
    eza
    fd
    fzf
    gdu
    glow
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
