{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }: {
    homeConfigurations = {
      "macosx" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          flake = self;
          username = "theodo";
          nixpkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
        };
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ ./hosts/macosx.nix ];
      };

      "gentoo" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          flake = self;
          username = "gentty";
          nixpkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./hosts/gentoo.nix ];
      };
    };

  };
}
