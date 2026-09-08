{ flake, ... }:

{
  xdg.configFile."kitty" = {
    source = "${flake}/.config/kitty";
    recursive = true;
  };
}
