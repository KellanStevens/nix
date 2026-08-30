{ lib, pkgs, ... }:

{
  dconf = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        scaling-factor = lib.hm.gvariant.mkUint32 2;
      };

      "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 900;

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = 0;
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-timeout = 0;
        sleep-inactive-battery-type = "nothing";
      };
    };
  };
}
