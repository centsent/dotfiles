{ flake, ... }:

{
  xdg.configFile."alacritty" = {
    source = "${flake}/.config/alacritty";
    recursive = true;
  };

}
