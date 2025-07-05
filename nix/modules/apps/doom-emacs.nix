{ pkgs, ... }:

let
  doom-src = pkgs.fetchFromGitHub {
    owner = "doomemacs";
    repo = "doomemacs";
  };
in
{
  home.packages = [ pkgs.emacs-pgtk ];

  home.file.".emacs.d" = {
    source = doom-src;
  };

  home.file.".doom.d" = {
    source = ../../.config/doom.d;
    recursive = true;
  };

  home.activation = {
    installAndSync = pkgs.lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -x "$HOME/.emacs.d/bin/doom" ]; then
        echo "Running 'doom sync'..."
        $HOME/.emacs.d/bin/doom --no-env sync
      fi
    '';
  };
}
