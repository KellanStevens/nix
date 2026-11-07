{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/homelab.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos";

  # Wired only: keep NetworkManager off the Wi-Fi card so it never connects.
  networking.networkmanager.unmanaged = [ "type:wifi" ];

  networking.firewall.interfaces.eno2.allowedTCPPorts = [ 3773 ];
}
