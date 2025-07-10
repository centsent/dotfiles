{ flake, ... }:

{
  home.file.".config/kitty" = {
    source = "${flake}/.config/kitty";
    recursive = true;
  };
}
