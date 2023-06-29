{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    android-tools
    broot
    cmake
    dotnet-sdk_7
    exa
    fd
    gcc
    git
    go
    gnumake
    fnlfmt
    httpie
    lazygit
    luajitPackages.fennel
    nodejs
    neovim
    openssh
    procs
    ripgrep
    rm-improved
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

  home.sessionVariables = {
    EDITOR = "neovim";
  };

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

    fish = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
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
}
