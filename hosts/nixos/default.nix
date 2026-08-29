{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/nixos
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Hostname
  networking.hostName = "nixos";

  # User account configuration
  users.users.kellan = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Kellan Stevens";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "render"
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGaZl4aI8q4/LSdvABWVesFV1GVaPlWarq1Bl2KbwKl"
    ];
  };

  system.stateVersion = "26.05";
}
