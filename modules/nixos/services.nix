{ ... }:

{
  imports = [
    ./services/avahi.nix
    ./services/home-assistant.nix
    ./services/nix-ld.nix
    ./services/ssh.nix
    ./services/stremio.nix
    ./services/traefik.nix
    ./services/unifi-endpoint.nix
    ./services/waydroid.nix
  ];
}
