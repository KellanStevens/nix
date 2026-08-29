{ pkgs, ... }:

{
  # Nix LD support
  programs.nix-ld.enable = true;

  # Docker Engine
  virtualisation.docker.enable = true;

  # Traefik Reverse Proxy
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
        };
        websecure = {
          address = ":443";
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          hassio = {
            rule = "Host(`hassio.local.kellanstevens.com`)";
            entryPoints = [ "web" "websecure" ];
            service = "hassio-service";
          };
        };

        services = {
          hassio-service = {
            loadBalancer = {
              servers = [
                {
                  url = "http://127.0.0.1:8123";
                }
              ];
            };
          };
        };
      };
    };
  };

  # UxPlay AirPlay Receiver Service
  systemd.user.services.uxplay = {
    description = "UxPlay AirPlay Receiver";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      ExecStart = "${pkgs.uxplay}/bin/uxplay -p -fs -nofreeze -reset 3 -hls -as 0 -nc no -fps 60 -s 1920x1080";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  # OpenSSH Server
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Avahi mDNS / Zeroconf Service Discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
