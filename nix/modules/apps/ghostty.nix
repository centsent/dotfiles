{ flake, ... }:

{
  home.file.".config/ghostty" = {
    source = "${flake}/.config/ghostty";
    recursive = true;
  };
}
