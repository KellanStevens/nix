{ ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

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
    ];
    allowedUDPPorts = [
      6000
      6001
      7011
    ];
  };

  # Disable power saving sleep states for server operation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
