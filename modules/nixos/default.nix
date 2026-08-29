{ ... }:

{
  imports = [
    ./desktop.nix
    ./network.nix
    ./services/home-assistant.nix
    ./services/ssh.nix
    ./services/traefik.nix
    ./services/uxplay.nix
  ];

  # Nix LD support for unpatched binaries
  programs.nix-ld.enable = true;

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
