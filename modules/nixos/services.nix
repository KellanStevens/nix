{ pkgs, ... }:

{
  # Nix LD support
  programs.nix-ld.enable = true;

  # Docker & Container Services
  virtualisation.docker.enable = true;
  virtualisation.oci-containers = {
    backend = "docker";
    containers."nginx-proxy-manager" = {
      image = "jc21/nginx-proxy-manager:latest";
      ports = [
        "80:80"
        "443:443"
        "81:81"
      ];
      volumes = [
        "/var/lib/npm/data:/data"
        "/var/lib/npm/letsencrypt:/etc/letsencrypt"
      ];
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
