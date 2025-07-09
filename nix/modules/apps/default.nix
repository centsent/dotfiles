{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./doom-emacs.nix
    ./ideavimrc.nix
    ./kitty.nix
    ./neovim.nix
    ./starship.nix
    ./topgrade.nix
  ];

  home.packages = with pkgs; [];
}
