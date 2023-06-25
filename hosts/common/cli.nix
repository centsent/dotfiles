{ config, pkgs, ... }: {

  home.packages = with pkgs; [
    alacritty
    android-tools
    broot
    cmake
    exa
    fd
    gcc
    git
    gnumake
    fnlfmt
    httpie
    lazygit
    luajitPackages.fennel
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
    xcp
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
