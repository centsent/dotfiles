{ pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.85"; # Note: Kitty expects this as a string
    };
  };
}
