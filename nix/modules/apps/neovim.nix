{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.neovim ];

  home.file.".config/nvim" = {
    source = "${flake}/.config/nvim";
    recursive = true;
  };
}
