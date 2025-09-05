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
    gh
    git-open
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
    yq
    zellij
  ];
}
