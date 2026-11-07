{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos-dell";
}
