{ nixpkgs-unstable, ... }:

{
  home.packages = [ nixpkgs-unstable.mise ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    packages = { flutter = "latest"; };
  };
}
