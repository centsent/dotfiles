{ nixpkgs-unstable, flake, ... }:

{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    package = nixpkgs-unstable.mise;
  };

  home.file.".config/mise" = { source = "${flake}/.config/mise"; };
}
