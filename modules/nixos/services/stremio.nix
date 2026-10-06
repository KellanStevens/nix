{ ... }:

{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers.stremio = {
      image = "docker.io/tsaridas/stremio-docker:latest";
      ports = [
        "11470:11470" # streaming server
        "8080:8080" # bundled web UI
      ];
      volumes = [ "/var/lib/stremio:/root/.stremio-server" ];
      environment.NO_CORS = "1";
    };
  };

  systemd.tmpfiles.rules = [ "d /var/lib/stremio 0755 root root -" ];

  networking.firewall.allowedTCPPorts = [
    11470
    8080
  ];
}
