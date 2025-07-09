{ pkgs, flake, ... }:
{
  home.packages = [ pkgs.topgrade ];

  home.file.".config/topgrade.toml" = {
    source = "${flake}/.config/topgrade.toml";
  };
}
