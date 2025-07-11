{
  description = "My personal dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "macosx" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          flake = self;
          username = "theodo";
        };
        pkgs = nixpkgs.legacyPackages.x86_64-darwin;
        modules = [ ./hosts/macosx.nix ];
      };

      "gentoo" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {
          flake = self;
          username = "gentty";
        };
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [ ./hosts/gentoo.nix ];
      };
    };
    
  };
}
