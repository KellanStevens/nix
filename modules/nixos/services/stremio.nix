{ ... }:

{
  virtualisation.podman.enable = true;

  virtualisation.oci-containers = {
    backend = "podman";
    containers.stremio = {
      # Pinned by digest so a changed upstream tag can't swap the image. Bump
      # with: skopeo inspect docker://docker.io/tsaridas/stremio-docker:latest
      image = "docker.io/tsaridas/stremio-docker@sha256:0f33301d0c7fcda21408cbd9923b67393ff2866d3896028bd3d69283a18fdb68";
      ports = [
        "11470:11470" # streaming server
        "8080:8080" # bundled web UI
      ];
      volumes = [ "/var/lib/stremio:/root/.stremio-server" ];
      environment = {
        NO_CORS = "1";
        AUTO_SERVER_URL = "1";
      };
    };
  };

  systemd.tmpfiles.rules = [ "d /var/lib/stremio 0700 root root -" ];

  networking.firewall.allowedTCPPorts = [
    11470
    8080
  ];
}
