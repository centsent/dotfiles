{ pkgs, ... }:
{
  home.packages = [ pkgs.topgrade ];

  home.file.".config/topgrade.toml" = {
    source = ../../.config/topgrade.toml;
  };
}
