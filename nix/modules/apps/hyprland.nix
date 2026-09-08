{ flake, ... }: {
  xdg.configFile."hypr" = {
    source = "${flake}/.config/hypr";
    recursive = true;
  };
}
