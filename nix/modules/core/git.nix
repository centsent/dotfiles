{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
  ];

  programs.git = {
    enable = true;
    userName = "centsent";
    userEmail = "2985258+centsent@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
