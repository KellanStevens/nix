{ ... }:

{
  # Services that only run on the home server (hosts/nixos).
  imports = [
    ./services/home-assistant.nix
    ./services/stremio.nix
    ./services/traefik.nix
    ./services/unifi-endpoint.nix
  ];
}
