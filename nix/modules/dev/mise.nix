{ nixpkgs-unstable, flake, lib, pkgs, ... }:

{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;

    package = nixpkgs-unstable.mise;
  };

  home.file.".config/mise" = { source = "${flake}/.config/mise"; };

  home.activation.miseInstallTools =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      MISE_EXEC=${pkgs.lib.getExe nixpkgs-unstable.mise}

      if [ -x "$MISE_EXEC" ]; then
        echo "Running 'mise install' to sync tools defined in config.toml..."
        $MISE_EXEC install
      fi
    '';
}
