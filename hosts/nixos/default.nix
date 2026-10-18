{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/nixos
    ../../modules/tailscale.nix
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Hostname
  networking.hostName = "nixos";

  # Restart tailscaled whenever it exits, not just on failure.
  systemd.services.tailscaled.serviceConfig.Restart = "always";

  # Terminfo for Ghostty so SSH sessions from the Macs (TERM=xterm-ghostty) work.
  environment.systemPackages = [ pkgs.ghostty.terminfo ];

  # User account configuration
  users.users."kellan.stevens" = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/kellan.stevens";
    shell = pkgs.zsh;
    description = "Kellan Stevens";
    # Start this user's systemd instance at boot so user services run
    # without anyone logging in at the console.
    linger = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];

    openssh.authorizedKeys.keys = [
      # Work Mac (TL-FW21FX96ND)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGaZl4aI8q4/LSdvABWVesFV1GVaPlWarq1Bl2KbwKl"
      # Personal Mac (macbook-pro)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID9cVMBQ/TjZvTGguxXMAcsyufKnaFDEJYXgWiqFwQpX"
    ];
  };

  system.stateVersion = "26.05";
}
