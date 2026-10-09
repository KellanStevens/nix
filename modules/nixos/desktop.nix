{ pkgs, inputs, ... }:

{
  imports = [
    inputs.helium.nixosModules.default
  ];

  # Graphics & Display
  hardware.graphics.enable = true;

  # Headless: no display manager or console session. Plasma is installed only
  # for the X11 session served over VNC by the user service in
  # modules/home/nixos/desktop.nix (port 5900, opened in network.nix).
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
  services.desktopManager.plasma6.enable = true;

  # KDE's native VNC/RDP client.
  environment.systemPackages = [ pkgs.kdePackages.krdc ];

  # Never suspend: the machine runs headless as a server.
  systemd.sleep.settings.Sleep = {
    AllowSuspend = false;
    AllowHibernation = false;
    AllowHybridSleep = false;
    AllowSuspendThenHibernate = false;
  };

  # Helium browser
  programs.helium.enable = true;

  # Audio (Pipewire)
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

  # Printing
  services.printing.enable = true;
}
