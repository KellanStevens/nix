{
  description = "Kellan's Multi-Host & Cross-Platform Flake Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium.url = "github:oxcl/nix-flake-helium-browser";
  };

  outputs = { self, nixpkgs, home-manager, darwin, helium, ... }@inputs: {
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

    # Template for macOS (nix-darwin) setup when ready
    darwinConfigurations = {
      # macbook = darwin.lib.darwinSystem {
      #   system = "aarch64-darwin"; # or "x86_64-darwin"
      #   specialArgs = { inherit inputs; };
      #   modules = [
      #     ./hosts/macbook
      #     home-manager.darwinModules.home-manager
      #     {
      #       home-manager.useGlobalPkgs = true;
      #       home-manager.useUserPackages = true;
      #       home-manager.extraSpecialArgs = { inherit inputs; };
      #       home-manager.users."kellan.stevens" = import ./modules/home;
      #     }
      #   ];
      # };
    };
  };
}
