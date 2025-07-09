{ pkgs, flake, ... }:

{
  home.packages = [ pkgs.starship ];

  home.file.".config/starship.toml" = {
    source = "${flake}/.config/starship.toml";
  };

  programs.starship.enableZshIntegration = true;
}
