{ ... }:

{
  networking.networkmanager.enable = true;
  # Wired only: keep NetworkManager off the Wi-Fi card so it never connects.
  networking.networkmanager.unmanaged = [ "type:wifi" ];

  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      81
      53317 # LocalSend
    ];
    allowedUDPPorts = [
      53317 # LocalSend discovery
    ];
  };

  # Disable power saving sleep states for server operation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
