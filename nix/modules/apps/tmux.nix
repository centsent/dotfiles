{ pkgs, flake, ... }:

let
  tmux-src = (import ../../sources.nix { inherit pkgs; }).tmux;

in
{
  home.packages = [ pkgs.tmux ];

  xdg.configFile = {
    "tmux/tmux.conf" = {
      source = "${tmux-src}/.tmux.conf";
    };

    "tmux/tmux.conf.local" = {
      source = "${flake}/.config/.tmux.conf.local";
    };
  };

  # Oh My Tmux loads the TPM plugins declared in tmux.conf.local. Keep one
  # plugin manager; programs.tmux.plugins does nothing unless its module is enabled.
}
