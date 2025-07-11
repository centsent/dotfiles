{ pkgs, lib, ... }:

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

  home.activation = {
    installAndSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ -x "$HOME/.config/emacs/bin/doom" ]; then
        echo "Running 'doom install'..."
        export PATH=${pkgs.emacs-pgtk}/bin:${pkgs.git}/bin:$PATH
        $HOME/.config/emacs/bin/doom install
      fi
    '';
  };
}
