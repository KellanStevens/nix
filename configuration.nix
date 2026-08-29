# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  networking.firewall.allowedTCPPorts = [
    80
    443
    81
    7000
    7001
    7100
    5900
  ];
  networking.firewall.allowedUDPPorts = [
    6000
    6001
    7011
  ];

  hardware.graphics.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nix-ld.enable = true;

  programs.bash.interactiveShellInit = ''
    fastfetch
  '';

  systemd.user.services.uxplay = {
    description = "UxPlay AirPlay Receiver";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    environment = {
      DISPLAY = ":0";
    };

    serviceConfig = {
      ExecStart = "${pkgs.uxplay}/bin/uxplay -p -fs -nofreeze -reset 3 -hls -as 0 -nc no -fps 60 -s 1920x1080";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  virtualisation.docker.enable = true;

  virtualisation.oci-containers.containers."nginx-proxy-manager" = {
    image = "jc21/nginx-proxy-manager:latest";
    ports = [
      "80:80"
      "443:443"
      "81:81"
    ];
    volumes = [
      "/var/lib/npm/data:/data"
      "/var/lib/npm/letsencrypt:/etc/letsencrypt"
    ];
  };

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  programs.helium.enable = true;

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.desktopManager.pantheon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    raopOpenFirewall = true;
    extraConfig.pipewire = {
      "10-airplay" = {
        "context.modules" = [
          {
            name = "libpipewire-module-raop-discover";
          }
        ];
      };
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    publish = {
      enable = true;
      userServices = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kellan = {
    isNormalUser = true;
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

    packages = with pkgs; [
      firefox
      git
      vim
      stremio-linux-shell
      fastfetch
      wget
      nixfmt-rfc-style
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  networking.firewall.enable = true;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  networking.networkmanager.wifi.powersave = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
