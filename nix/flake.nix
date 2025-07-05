{
  description = "My Personal Home Manager Configuration Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # Using a stable release is recommended

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {

    homeConfigurations."centsent" = home-manager.lib.homeManagerConfiguration {
      # The package set to use.
      # Change this based on your system's architecture.
      # - "x86_64-linux" for Intel/AMD Linux
      # - "aarch64-linux" for ARM Linux
      # - "x86_64-darwin" for Intel Macs
      # - "aarch64-darwin" for Apple Silicon Macs
      # pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # The list of configuration files to import.
      # This is where you tell Home-Manager to use your home.nix file.
      modules = [ ./home.nix ];

      # Optional: You can pass extra arguments to your modules here
      # extraSpecialArgs = { ... };
    };

    # You can define more configurations for other users or machines here
    # homeConfigurations."work-user@work-laptop" = ...
  };
}
