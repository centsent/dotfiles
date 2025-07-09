{ pkgs, flake, lib, ... }:

let
  tmux-src = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master";
    hash = "sha256-2KFT9v/PGb2K8Vd2eL=";
  };
in
{
  home.packages = [ pkgs.tmux ];

  home.file.".tmux" = {
    source = tmux-src;
    recursive = true;
  };
}
