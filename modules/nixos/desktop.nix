{ pkgs, inputs, ... }:

{
  imports = [
    inputs.helium.nixosModules.default
  ];

  # Graphics & Display
  hardware.graphics.enable = true;

  # Graphical login & GNOME Desktop
  services.xserver = {
    enable = true;
    xkb = {
      layout = "za";
      variant = "";
    };
  };
  services.desktopManager.gnome.enable = true;

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
