{ flake, lib, pkgs, ... }:

{
  home.file.".config/mise" = { source = "${flake}/.config/mise"; };

  home.activation.miseInstall = lib.hm.dag.entryBefore [ "writeBoundary" ] ''
    MISE_BIN="$HOME/.local/bin/mise"

    if [ ! -x "$MISE_BIN" ]; then
      echo "Installing mise via official installation script..."
      export PATH="${pkgs.coreutils}/bin:${pkgs.gnutar}/bin:${pkgs.gzip}/bin:${pkgs.xz}/bin:${pkgs.bzip2}/bin:${pkgs.zstd}/bin:${pkgs.curl}/bin:$PATH"
      curl -sSfL https://mise.run | sh
    else
      echo "mise is already installed at $MISE_BIN"
    fi
  '';

  home.activation.miseInstallTools =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      MISE_BIN="$HOME/.local/bin/mise"

      if [ -x "$MISE_BIN" ]; then
        echo "Running 'mise install' to sync tools defined in config.toml..."
        $MISE_BIN install
      else
        echo "Warning: mise not found at $MISE_BIN"
      fi
    '';
}
