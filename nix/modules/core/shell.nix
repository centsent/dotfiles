{ pkgs, flake, ... }:

{
  imports = [
    ./zsh-aliases.nix
    ./zsh-init.nix
    ./packages.nix
    ./environment.nix
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

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/topgrade.toml" = {
    source = "${flake}/.config/topgrade.toml";
  };
}
