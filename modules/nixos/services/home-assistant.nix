{ ... }:

{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "default_config"
      "met"
      "esphome"
    ];
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

  # Home Assistant runs its own mDNS (zeroconf) to discover and resolve ESPHome
  # devices, so it needs the replies on UDP 5353.
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
