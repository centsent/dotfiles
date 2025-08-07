{ flake, ... }: {
  home.file.".config/hypr" = {
    source = "${flake}/.config/hypr";
    recursive = true;
  };
}
