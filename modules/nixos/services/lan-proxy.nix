{ pkgs, ... }:

let
  parent = "eno2";
  subnet = "10.20.1.0/24";
  address = "10.20.1.2";
  lan = "10.0.0.0/24";
  backend = "10.88.0.1";

  ports = [
    80
    443
    8080
    11470
  ];

  nginxConf = pkgs.writeText "lan-proxy-nginx.conf" ''
    worker_processes 1;
    error_log /dev/stderr warn;
    pid /tmp/nginx.pid;

    events { }

    stream {
    ${pkgs.lib.concatMapStrings (port: ''
      server {
        listen ${address}:${toString port};
        proxy_pass ${backend}:${toString port};
      }
    '') ports}
    }
  '';

  start = pkgs.writeText "lan-proxy-start.sh" ''
    set -eu
    dev=$(ip -o -4 addr show | awk '$4 == "${address}/24" { print $2 }')
    ip route replace ${lan} dev "$dev" src ${address}
    exec nginx -c /etc/nginx/nginx.conf -g 'daemon off;'
  '';
in
{
  virtualisation.podman.enable = true;

  systemd.services.podman-network-lan-proxy = {
    description = "Podman macvlan network for the LAN proxy";
    wantedBy = [ "multi-user.target" ];
    before = [ "podman-lan-proxy.service" ];
    requiredBy = [ "podman-lan-proxy.service" ];
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      podman network exists lan-proxy || podman network create \
        --driver macvlan \
        --opt parent=${parent} \
        --opt no_default_route=1 \
        --subnet ${subnet} \
        lan-proxy
    '';
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.lan-proxy = {
      image = "docker.io/library/nginx:stable-alpine";
      networks = [
        "podman"
        "lan-proxy:ip=${address}"
      ];
      capabilities.NET_ADMIN = true;
      volumes = [
        "${nginxConf}:/etc/nginx/nginx.conf:ro"
        "${start}:/start.sh:ro"
      ];
      entrypoint = "/bin/sh";
      cmd = [ "/start.sh" ];
    };
  };
}
