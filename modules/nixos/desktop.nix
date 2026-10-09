{ pkgs, inputs, ... }:

{
  imports = [
    inputs.helium.nixosModules.default
  ];

  # Graphics & Display
  hardware.graphics.enable = true;

  # Headless GNOME served over RDP (rdp://<host>:3389). There is no screen, so
  # GDM only exists to start a headless session for the user at boot; the user's
  # gnome-remote-desktop then serves that session. Set it up once with the
  # commands in modules/home/nixos/desktop.nix.
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.gnome-remote-desktop.enable = true;
  # A full replacement for GDM's gnome-headless-session@.service template, which
  # requires gdm.service while NixOS runs GDM as display-manager.service. Keep
  # the instance name: GDM's polkit rule only lets a unit with that name start a
  # session for that user.
  systemd.services."gnome-headless-session@kellan.stevens" = {
    description = "GNOME headless session for kellan.stevens";
    requires = [ "display-manager.service" ];
    after = [ "display-manager.service" ];
    wantedBy = [ "graphical.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.gdm}/libexec/gdm-new-session kellan.stevens --headless";
      Group = "gdm";
      DynamicUser = true;
      # gdm-new-session lasts as long as the session, so bring the session back
      # whenever it ends; the delay lets the old one finish shutting down first.
      Restart = "always";
      RestartSec = 5;
    };
  };
  networking.firewall.allowedTCPPorts = [ 3389 ];

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
  };

  # Printing
  services.printing.enable = true;
}
