{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./ideavimrc.nix
    ./kitty.nix
    ./neovim.nix
    ./starship.nix
    ./topgrade.nix
  ];

  home.packages = with pkgs; [
    wechat
  ];
}
