{ pkgs, ... }:

let
  rimePath =
    if pkgs.stdenv.isDarwin then "/Library/Rime"
    else if pkgs.stdenv.isLinux then "/.local/share/fcitx5/rime"
    else null;
in
{
  home.file.".config/rime" = {
    source = ../../.config/rime;
    recursive = true;
  };
}
