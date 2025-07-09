{ pkgs, flake, ... }:
{
  home.file.".ideavimrc" = {
    source = "${flake}/.ideavimrc";
  };
}
