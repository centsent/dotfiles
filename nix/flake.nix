{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      sops-nix,
      ...
    }:
    let
      hosts = {
        macosx = {
          system = "x86_64-darwin";
          username = "theodo";
        };
        gentoo = {
          system = "x86_64-linux";
          username = "gentty";
        };
      };
      forSystems = nixpkgs.lib.genAttrs (map (host: host.system) (builtins.attrValues hosts));
      packageConfig = system: {
        # This Intel Mac stays on the last supported release, Nixpkgs 26.05.
        allowDeprecatedx86_64Darwin = system == "x86_64-darwin";
      };
      pkgsFor = forSystems (
        system:
        import nixpkgs {
          inherit system;
          config = packageConfig system;
        }
      );
      mkHome =
        name:
        { system, username }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.${system};
          extraSpecialArgs = {
            flake = self;
            inherit username;
            nixpkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config = packageConfig system;
            };
          };
          modules = [
            { nixpkgs.config = packageConfig system; }
            sops-nix.homeManagerModules.sops
            ./hosts/${name}.nix
          ];
        };
    in
    {
      formatter = forSystems (system: pkgsFor.${system}.nixfmt);
      homeConfigurations = builtins.mapAttrs mkHome hosts;

      # The first switch uses this CLI directly; subsequent generations also
      # install it through programs.home-manager.enable.
      packages = forSystems (system: {
        home-manager = pkgsFor.${system}.callPackage "${home-manager}/home-manager" {
          path = "${home-manager}";
        };
      });

      # Fetch and verify every pinned external source during normal CI checks.
      checks = forSystems (
        system:
        let
          pkgs = pkgsFor.${system};
          sources = import ./sources.nix { inherit pkgs; };
        in
        {
          sources = pkgs.linkFarm "dotfiles-sources" (
            nixpkgs.lib.mapAttrsToList (name: path: { inherit name path; }) sources
          );
        }
      );
    };
}
