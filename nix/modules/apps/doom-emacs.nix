{ pkgs, lib, ... }:
{
  # Ansible owns the mutable Doom checkout and repository configuration links.
  home.packages = [
    pkgs.emacs-pgtk
    (pkgs.writeShellApplication {
      name = "dotfiles-doom-sync";
      runtimeInputs = [
        pkgs.emacs-pgtk
        pkgs.git
      ];
      text = ''
        doom="$HOME/.config/emacs/bin/doom"
        if [[ ! -x "$doom" ]]; then
          echo "Doom is missing. Run make doom-emacs from the dotfiles checkout first." >&2
          exit 1
        fi
        if [[ "''${1:-}" == --install ]]; then
          shift
          exec "$doom" install "$@"
        fi
        exec "$doom" sync "$@"
      '';
    })
  ];

  xdg.desktopEntries.emacs-doom = lib.mkIf pkgs.stdenv.isLinux {
    name = "Emacs (Doom)";
    comment = "Text Editor";
    exec = "${pkgs.emacs-pgtk}/bin/emacs";
    icon = "emacs";
    terminal = false;
    categories = [
      "Development"
      "TextEditor"
    ];
  };
  home.sessionPath = [ "$HOME/.config/emacs/bin" ];
}
