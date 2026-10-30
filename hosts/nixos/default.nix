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

  # Never suspend: the machine runs headless as a server.
  systemd.sleep.settings.Sleep = {
    AllowSuspend = false;
    AllowHibernation = false;
    AllowHybridSleep = false;
    AllowSuspendThenHibernate = false;
  };

  # Restart tailscaled whenever it exits, not just on failure.
  systemd.services.tailscaled.serviceConfig.Restart = "always";

  environment.systemPackages = [
    # Terminfo for Ghostty so SSH sessions from the Macs (TERM=xterm-ghostty) work.
    pkgs.ghostty.terminfo
    # Node.js, for npx.
    pkgs.nodejs
    pkgs.python3
    pkgs.uv
    pkgs.ripgrep
    pkgs.fd
    pkgs.yq-go
    pkgs.tree
    pkgs.curl
    pkgs.unzip
    pkgs.zip
    pkgs.gnumake
    pkgs.gcc
    pkgs.htop
    pkgs.file
    pkgs.diffutils
    pkgs.patch
    pkgs.gnused
    pkgs.gawk
    pkgs.gnutar
    pkgs.gzip
    pkgs.findutils
    pkgs.which
    pkgs.shellcheck
  ];

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
