{ pkgs, flake, lib, ... }:

let
  doom-src = pkgs.fetchFromGitHub {
    owner = "doomemacs";
    repo = "doomemacs";
    rev = "master";
    hash = "sha256-2KFT9v/PGb2K8Vd2eLAhDFQW6ORQapmQmBXipObpkoo=";
  };
in
{
  home.packages = [ pkgs.emacs-pgtk ];

  home.file.".config/emacs" = {
    source = doom-src;
    recursive = true;
  };

  home.file.".doom.d" = {
    source = "${flake}/.config/doom.d";
    recursive = true;
  };

  home.file.".local/share/applications/emacs-doom.desktop" = lib.mkIf pkgs.stdenv.isLinux {
    text = ''
      [Desktop Entry]
      Name=Emacs (Doom)
      Comment=Text Editor
      Exec=${pkgs.emacs-pgtk}/bin/emacs
      Icon=emacs
      Terminal=false
      Type=Application
      Categories=Development;Editor;
    '';
  };

  # home.sessionVariables.PATH = "$HOME/.config/emacs/bin:$PATH";

  home.activation = {
    installAndSync = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -x "$HOME/.config/emacs/bin/doom" ]; then
        echo "Running 'doom install'..."
        export DOOMDIR=$HOME/.doom.d
        export PATH=${pkgs.emacs-pgtk}/bin:${pkgs.git}/bin:$PATH
        export DOOMLOCALDIR=$HOME/.local/share/doom
        $HOME/.config/emacs/bin/doom install
      fi
    '';
  };
}
