{
  description = "Kellan's Multi-Host & Cross-Platform Flake Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
    let
      # A Mac shares hosts/macos/common.nix and modules/home, plus its own
      # host module and home module for machine-specific apps and aliases.
      mkDarwin =
        { host, home }:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            host
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users."kellan.stevens".imports = [
                ./modules/home
                home
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/nixos
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users."kellan.stevens" = import ./modules/home;
            }
          ];
        };
      };

      darwinConfigurations = {
        "TL-FW21FX96ND" = mkDarwin {
          host = ./hosts/macos/work;
          home = ./modules/home/macos/work.nix;
        };

        "macbook-pro" = mkDarwin {
          host = ./hosts/macos/personal;
          home = ./modules/home/macos/personal.nix;
        };
      };
    };
}
