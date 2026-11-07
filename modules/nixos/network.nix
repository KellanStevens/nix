{ ... }:

{
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      81
      53317
    ];
    allowedUDPPorts = [
      53317
    ];
  };

  # Disable power saving sleep states for server operation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
