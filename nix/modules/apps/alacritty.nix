{ pkgs, ... }:

{
  home.packages = [ pkgs.alacritty ];

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        bright = {
          black = "#27272a";
          blue = "#aca1cf";
          cyan = "#ea83a5";
          green = "#90b99f";
          magenta = "#e29eca";
          red = "#f5a191";
          white = "#c1c0d4";
          yellow = "#e6b99d";
        };
        cursor = {
          cursor = "#757581";
          text = "#c9c7cd";
        };
        normal = {
          black = "#32344a";
          blue = "#7aa2f7";
          cyan = "#449dab";
          green = "#9ece6a";
          magenta = "#ad8ee6";
          red = "#f7768e";
          white = "#9699a8";
          yellow = "#e0af68";
        };
        primary = {
          background = "#161617";
          foreground = "#c9c7cd";
        };
      };
      env = {
        TERM = "xterm-256color";
      };
      font = {
        size = 13.0;
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font Mono";
          style = "Bold";
        };
      };
      window = {
        opacity = 0.75;
        option_as_alt = "Both";
        decorations = "buttonless";
        startup_mode = "Windowed";
        padding = {
          x = 12;
          y = 12;
        };
      };
      terminal = {
        shell = {
          program = "zsh";
          args = [ "-l" "-c" "tmux attach || tmux" ];
        };
      };
    };
  };
}
