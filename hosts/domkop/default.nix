{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/base.nix
    ../../modules/nixos/homelab.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Keep the ESP (and the systemd-boot random seed on it) root-only.
  fileSystems."/boot/efi".options = [
    "fmask=0077"
    "dmask=0077"
  ];

  networking.hostName = "domkop";

  # Wired only: keep NetworkManager off the Wi-Fi card so it never connects.
  networking.networkmanager.unmanaged = [ "type:wifi" ];

  networking.firewall.interfaces.eno2.allowedTCPPorts = [ 3773 ];
}
