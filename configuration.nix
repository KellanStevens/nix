{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos";
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

  time.timeZone = "Africa/Johannesburg";

  i18n.defaultLocale = "en_ZA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  programs.helium.enable = true;

  services.xserver.displayManager.lightdm.enable = true;
  services.desktopManager.pantheon.enable = true;

  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
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
  system.stateVersion = "26.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
