{ flake, ... }:

{
  xdg.configFile."ghostty" = {
    source = "${flake}/.config/ghostty";
    recursive = true;
  };
}
