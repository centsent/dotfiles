{ config, lib, ... }:

with lib;

let cfg = config.programs.nixgl;
in {
  options.programs.nixgl = {
    enable = mkEnableOption "nixGL OpenGL wrapper";
    package = mkOption {
      type = types.package;
      default = (import (builtins.fetchTarball
        "https://github.com/nix-community/nixGL/archive/main.tar.gz")
        { }).auto.nixGLDefault;
      description = "nixGL package variant";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.sessionVariables = { NIX_GL_WRAPPER = "${cfg.package}/bin/nixGL"; };
  };
}
