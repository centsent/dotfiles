{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./doom-emacs.nix
    ./ghostty.nix
    ./ideavimrc.nix
    ./kitty.nix
    ./starship.nix
    ./topgrade.nix
    ./tmux.nix
    ./yazi.nix
  ];
}
