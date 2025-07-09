{ pkgs, flake, ... }:

let
  tmux-src = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master";
    hash = "sha256-4Mvq3bJMnnUBclj7Ld6mPRsgzqdm9gubFMKTXcDIvu0=";
  };
in
{
  home.packages = [ pkgs.tmux ];

  home.file = {
    ".config/tmux/tmux.conf" = {
      source = "${tmux-src}/.tmux.conf";
    };

    ".config/tmux/tmux.conf.local" = {
      source = "${flake}/.config/.tmux.conf.local";
    };
  };

  programs.tmux = {
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
      fzf
      tpm
    ];
  };
}
