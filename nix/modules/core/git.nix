{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "centsent";
        email = "2985258+centsent@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
