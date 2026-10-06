{ pkgs, inputs, ... }:

{
  imports = [
    inputs.helium.nixosModules.default
  ];

  # Graphics & Display
  hardware.graphics.enable = true;

  # Apple ISO keyboards otherwise have the ` ~ key and the key beside left Shift
  # swapped by the hid_apple driver.
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  # Graphical login & KDE Plasma (Wayland)
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  services.displayManager.autoLogin = {
    enable = true;
    user = "kellan.stevens";
  };

  # Keep the display's idle blanking separate from system sleep.
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
