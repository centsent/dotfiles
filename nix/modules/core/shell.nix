{ pkgs, flake, ... }:

let
  # Dynamically set ANDROID_HOME based on the OS
  androidHome = if pkgs.stdenv.isDarwin 
               then "$HOME/Library/Android/Sdk"
               else "$HOME/Android/Sdk";
in
{
  imports = [
    ./zsh-aliases.nix
  ];

  # --- Zsh Program Configuration ---
  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [
        "history" 
        "completion" 
        "match_prev_cmd"
      ];
      highlight = "fg=#7dcfff,bg=#1a1b26,underline";
    };
    syntaxHighlighting.enable = true;

    # --- Oh My Zsh Configuration ---
    oh-my-zsh = {
      enable = true;

      theme = "robbyrussell";
      plugins = [
        "git"
        "tmux"
      ];
    };

    initContent = ''
      export PATH="$PATH:$HOME/.bun/bin"
      export PATH="$PATH:$HOME/go/bin"
      export PATH="$PATH:$HOME/.pub-cache/bin"

      export ANDROID_HOME="${androidHome}"
      export PATH="$PATH:$ANDROID_HOME/platform-tools"
      export PATH="$PATH:$ANDROID_HOME/tools"
      export PATH="$PATH:$ANDROID_HOME/tools-bin"
      export PATH="$PATH:$ANDROID_HOME/emulator"

      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
