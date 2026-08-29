{ ... }:

{
  imports = [
    ./services/avahi.nix
    ./services/docker.nix
    ./services/home-assistant.nix
    ./services/nix-ld.nix
    ./services/ssh.nix
    ./services/traefik.nix
    ./services/uxplay.nix
  ];
}
