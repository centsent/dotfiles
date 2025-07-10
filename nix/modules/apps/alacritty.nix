{ flake, ... }:

{
  home.file.".config/alacritty" = {
    source = "${flake}/.config/alacritty";
    recursive = true;
  };

}
