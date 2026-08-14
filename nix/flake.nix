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
    {
      # Systems here must match the ones the homeConfigurations below are
      # built for, or `nix fmt` fails on the machine it is run from.
      # nixfmt-rfc-style is now an alias for nixfmt and warns on evaluation.
      formatter = {
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
        x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixfmt;
      };

      homeConfigurations = {
        "macosx" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            flake = self;
            username = "theodo";
            nixpkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-darwin;
          };
          pkgs = nixpkgs.legacyPackages.x86_64-darwin;
          modules = [
            sops-nix.homeManagerModules.sops
            ./hosts/macosx.nix
          ];
        };

        "gentoo" = home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            flake = self;
            username = "gentty";
            nixpkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
          };
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            sops-nix.homeManagerModules.sops
            ./hosts/gentoo.nix
          ];
        };
      };

    };
}
