{ pkgs, flake, ... }:

{
  imports = [
    ./zsh-aliases.nix
    ./zsh-init.nix
  ];

  home.packages = with pkgs; [
    age
    bat
    btop
    eza
    fd
    fzf
    glow
    jq
    lazygit
    ripgrep
    sops
    tokei
    wakatime-cli
  ];

   # --- Zsh Program Configuration ---
  programs.zsh = {
    enable = true;

    # --- Oh My Zsh Configuration ---
    oh-my-zsh = {
      enable = true;

      theme = "robbyrussell";
      plugins = [
        "git"
        "tmux"
      ];
    };
  };

  # --- Environment Variables ---
  home.sessionVariables = {
    BUN_INSTALL = "$HOME/.bun";
    GOPATH = "$HOME/go";

    # Dynamically set ANDROID_HOME based on the OS
    ANDROID_HOME = if pkgs.stdenv.isDarwin then "$HOME/Library/Android/Sdk" else "$HOME/Android/Sdk";
  };

  # --- PATH Modifications ---
  home.sessionPath = [
    "$HOME/.bun/bin"
    "$HOME/go/bin"
    "$HOME/.pub-cache/bin"
    "$ANDROID_HOME/platform-tools"
    "$ANDROID_HOME/tools"
    "$ANDROID_HOME/tools/bin"
    "$ANDROID_HOME/emulator"
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/topgrade.toml" = {
    source = "${flake}/.config/topgrade.toml";
  };
}
