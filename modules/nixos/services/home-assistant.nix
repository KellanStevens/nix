{ pkgs, ... }:

let
  # nixpkgs doesn't package HACS. The release zip ships the prebuilt frontend,
  # which the git source lacks.
  hacs = pkgs.buildHomeAssistantComponent rec {
    owner = "hacs";
    domain = "hacs";
    version = "2.0.5";

    src = pkgs.fetchzip {
      url = "https://github.com/hacs/integration/releases/download/${version}/hacs.zip";
      stripRoot = false;
      hash = "sha256-iMomioxH7Iydy+bzJDbZxt6BX31UkCvqhXrxYFQV8Gw=";
    };

    dependencies = [ pkgs.home-assistant.python3Packages.aiogithubapi ];
  };
in
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
    ];
    customComponents = [ hacs ];
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

  # The HomeKit Bridge serves HAP to Apple devices on this port by default.
  networking.firewall.allowedTCPPorts = [ 21064 ];
}
