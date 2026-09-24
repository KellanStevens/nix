{ ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  networking.nftables.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
      81
      7000
      7001
      7100
      5900
      53317 # LocalSend
    ];
    allowedUDPPorts = [
      6000
      6001
      7011
      53317 # LocalSend discovery
    ];
  };

  # Disable power saving sleep states for server operation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
