{ ... }:

{
  imports = [
    ./services/avahi.nix
    ./services/home-assistant.nix
    ./services/nix-ld.nix
    ./services/ssh.nix
    ./services/traefik.nix
    ./services/unifi-endpoint.nix
    ./services/uxplay.nix
    ./services/waydroid.nix
  ];
}
