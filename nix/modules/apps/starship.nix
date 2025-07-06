{ pkgs, ... }:
{
  home.packages = [ pkgs.starship ];

  home.file.".config/starship.toml" = {
    source = ../../.config/starship.toml;
  };

  # programs.zsh.initExtra = ''
  #   eval "$(starship init zsh)"
  # '';
}
