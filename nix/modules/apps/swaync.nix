{ flake, ... }:

{
  home.file.".config/swaync" = { source = "${flake}/.config/swaync"; };
}
