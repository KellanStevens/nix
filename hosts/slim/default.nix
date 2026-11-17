{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/services/minecraft.nix
  ];

  networking.hostName = "slim";
}
