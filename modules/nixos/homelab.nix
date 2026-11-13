{ ... }:

{
  # Services that only run on the home server (hosts/domkop).
  imports = [
    ./services/home-assistant.nix
    ./services/stremio.nix
    ./services/traefik.nix
    ./services/unifi-endpoint.nix
    ./services/lan-proxy.nix
  ];
}
