{ pkgs, ... }:

let
  fzf-tab-src = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "master";
    sha256 = "sha256-1Ior+/9e+M+Fc1u0uq5HhknlGRS96q7tazhEE6rmx9Y=";
  };
in {
  imports = [ ./zsh-aliases.nix ];

  # --- Zsh Program Configuration ---
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" "match_prev_cmd" ];
      highlight = "fg=#7dcfff,bg=#1a1b26,underline";
    };
    syntaxHighlighting.enable = true;

    # --- Oh My Zsh Configuration ---
    oh-my-zsh = {
      enable = true;

      theme = "robbyrussell";
      plugins = [ "git" "tmux" ];
    };

    initContent = ''
      source "${fzf-tab-src}/fzf-tab.plugin.zsh"

      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        unset __HM_SESS_VARS_SOURCED
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      if [ -x "$HOME/.local/bin/mise" ]; then
        eval "$($HOME/.local/bin/mise activate zsh)"
      fi
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
