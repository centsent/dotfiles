{ pkgs, ... }:
{
  home.packages = [ pkgs.starship ];

  home.file.".config/starship.toml" = {
    source = ../../.config/starship.toml;
  };

  programs.starship.enableZshIntegration = true;
}
