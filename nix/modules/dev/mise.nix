{ nixpkgs-unstable, ... }:

{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    package = nixpkgs-unstable.mise;
  };
}
