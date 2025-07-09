{ pkgs, flake, ... }:

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
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/topgrade.toml" = {
    source = "${flake}/.config/topgrade.toml";
  };
}
