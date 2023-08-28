{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, hm, ... }: {
    homeConfigurations = let
      macUsername = "theodo";
      macSystem = "x86_64-darwin";
      macPkgs = import nixpkgs {
        system = macSystem;
        config.allowUnfree = true;
      };
      
      wslUsername = "mafioso";
      wslSystem = "x86_64-linux";
      wslPkgs = import nixpkgs {
        system = wslSystem;
        config.allowUnfree = true;
      };
    in {
      ${macUsername} = hm.lib.homeManagerConfiguration {
        pkgs = macPkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/mac/x86_64.nix
          {
            home = {
              stateVersion = "23.11";
              username = "${macUsername}";
              homeDirectory = "/Users/${macUsername}";
            };
          }
        ];
      };
      
      ${wslUsername} = hm.lib.homeManagerConfiguration {
	      pkgs = wslPkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./hosts/wsl/default.nix
          {
            home = {
              stateVersion = "23.11";
              username = "${wslUsername}";
              homeDirectory = "/home/${wslUsername}";
            };
          }
        ];
      };
    };
  };
}
