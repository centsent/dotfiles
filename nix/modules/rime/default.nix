{ pkgs, flake, ... }:

let
  rimeDestPath =
    if pkgs.stdenv.isDarwin then "Library/Rime"
    else if pkgs.stdenv.isLinux then ".local/share/fcitx5/rime"
    else null;
in
{
  home.file = if rimeDestPath != null then {
    "${rimeDestPath}" = {
      source = "${flake}/.config/rime";
      recursive = true;
    };
  } else {};
}
