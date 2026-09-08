{ flake, pkgs, ... }:
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
  # Keep ownership of the directory used by previous generations. Managing a
  # child file would collide with the existing directory symlink into the store.
  xdg.configFile."mise".source = "${flake}/.config/mise";

  # Download toolchains deliberately, independently of home activation. Running
  # from HOME prevents a project's mise.toml from changing the selected tools.
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dotfiles-tools-sync";
      runtimeInputs = [ pkgs.mise ];
      text = ''
        cd "$HOME"
        exec mise install "$@"
      '';
    })
  ];
}
