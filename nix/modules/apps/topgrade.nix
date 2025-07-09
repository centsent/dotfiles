{ pkgs, ... }:
{
  programs.topgrade = {
    enable = true;
    settings = {
      misc = {
        disable = [
          "system"
          "vim"
          "containers"
          "node"
          "bun"
          "pnpm"
          "chezmoi"
          "ruby_gems"
        ];
      };
    };
  };
}
