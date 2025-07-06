{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    btop
    eza
    fd
    fzf
    jq
    ripgrep
    tokei
    zoxide
  ];
}
