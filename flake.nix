{
  description = "Kellan's Home Server Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    helium.url = "github:oxcl/nix-flake-helium-browser";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      specialArgs = { inherit inputs; };
      
      modules = [
        ./hardware-configuration.nix
        ./configuration.nix
        inputs.helium.nixosModules.default
      ];
    };
  };
}
