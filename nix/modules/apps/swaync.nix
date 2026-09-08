{ flake, ... }:

{
  xdg.configFile."swaync" = {
    source = "${flake}/.config/swaync";
  };
}
