# Personal MacBook.
{ ... }:

{
  imports = [
    ../common.nix
    ../../../modules/macos/homebrew/personal.nix
    ../../../modules/tailscale.nix
  ];

  networking.hostName = "macbook-pro";

  # The tailscaled daemon starts at boot but is not restarted if it exits.
  launchd.daemons.tailscaled.serviceConfig.KeepAlive = true;
}
