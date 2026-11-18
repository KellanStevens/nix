{ ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "default_config"
      "met"
      "esphome"
      "homekit"
      "homekit_controller"
      "matter"
      # HACS became the built-in Marketplace in 2026.11. On first start
      # Home Assistant migrates the old HACS data into it.
      "marketplace"
    ];
    extraPackages = ps: [ ps.paho-mqtt ];
    config = {
      default_config = {};
      http = {
        server_port = 8123;
        use_x_forwarded_for = true;
        trusted_proxies = [
          "127.0.0.1"
          "::1"
        ];
      };
    };
  };

  services.matter-server.enable = true;

  # Home Assistant runs its own mDNS (zeroconf) to discover and resolve ESPHome
  # devices, so it needs the replies on UDP 5353.
  networking.firewall.allowedUDPPorts = [ 5353 ];

  networking.firewall.allowedTCPPorts = [
    21064
    21065
  ];
}
