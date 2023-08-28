{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    ast-grep
    android-tools
    broot
    cargo
    cmake
    dotnet-sdk_7
    exa
    fd
    gcc
    git
    go
    google-java-format
    gnumake
    fnlfmt
    lazygit
    luajitPackages.fennel
    nodejs
    neovim
    openssh
    procs
    ripgrep
    rm-improved
    rustc
    scrcpy
    stow
    tmux
    tokei
    topgrade
    unzip
    wget
    xcp
    zellij
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        theme = "GitHub";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true; 
    };

    # fish = {
    #   enable = true;
    # };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    git = {
      enable = true;
      userName = "centsent";
      userEmail = "centsent@users.noreply.github.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      ignores = [
        ".DS_Store"
          "*.pyc"
      ];
    };

    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.file = {
    ".tmux.conf".source = ../../config/tmux.conf;
    ".ideavimrc".source = ../../config/.ideavimrc;
  };

  xdg.configFile = {
    "alacritty".source = ../../config/alacritty;
    "starship.toml".source = ../../config/starship.toml;
    "topgrade.toml".source = ../../config/topgrade.toml;
  };
}
