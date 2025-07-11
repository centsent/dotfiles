{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./doom-emacs.nix
    ./ideavimrc.nix
    ./kitty.nix
    ./starship.nix
    ./topgrade.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [ neovim ];
}
