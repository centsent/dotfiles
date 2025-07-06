{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    shellAliases = {
      l = "eza -al --icons";
      ls = "eza --grid --color --icons --all";
      ll = "eza -l";
      rm = "rip";
      cp = "xcp";
      tg = "topgrade";
      cat = "bat";
      ps = "procs";
      pn = "pnpm";
      seup = "sudo emerge --ask --verbose --update --deep --newuse @world";
      se = "sudo emerge --ask --verbose";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "tmux"
      ];
      custom = "$HOME/.config/zsh/oh-my-zsh-custom";
      plugins = [
        {
          name = "zsh-autosuggestions";
          file = "zsh-autosuggestions.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            hash = "sha256-DUG2v6zS+B+LwA1VjJ1b2n3v5yA4i2yXg5L4rG+m2kU=";
          };
        }
      ];
    };

    initExtra = ''
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7dcfff,bg=#1a1b26,underline"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
    '';
  };
  
  home.sessionVariables = {
    BUN_INSTALL = "$HOME/.bun";
    GOPATH = "$HOME/go";
    FLUTTER_ROOT = "${pkgs.flutter}/bin"; # Example if Flutter is managed by Nix
    ANDROID_HOME = if pkgs.stdenv.isDarwin then "$HOME/Library/Android/Sdk" else "$HOME/Android/Sdk";
  };
  
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/go/bin"
    "$HOME/.pub-cache/bin"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    "$ANDROID_HOME/emulator"
  ];
}
