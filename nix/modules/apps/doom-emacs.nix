{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.emacs-pgtk ];

  home.file.".local/share/applications/emacs-doom.desktop" =
    lib.mkIf pkgs.stdenv.isLinux {
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

  home.sessionPath = [ "$HOME/.config/emacs/bin" ];

  home.activation = {
    installAndSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -x "$HOME/.config/emacs/bin/doom" ]; then
        export PATH=${pkgs.emacs-pgtk}/bin:${pkgs.git}/bin:$PATH
        DOOM_EXEC="${config.home.homeDirectory}/.config/emacs/bin/doom"

        if [ -x "$DOOM_EXEC" ]; then
          echo "Running 'doom sync' to ensure environment is up-to-date..."
          $DOOM_EXEC sync
        else
          echo "Running 'doom install'..."
          $DOOM_EXEC install
        fi
      fi
    '';
  };
}
