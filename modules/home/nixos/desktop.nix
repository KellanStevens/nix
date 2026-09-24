{ lib, pkgs, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.isLinux [
    pkgs.vscode
    pkgs.ulauncher
    pkgs.github-desktop
  ];

  # Spotlight-style app launcher, toggled with Super+Space via the GNOME
  # keybinding below (Ulauncher's own hotkey grab doesn't work under Wayland).
  systemd.user.services.ulauncher = lib.mkIf pkgs.stdenv.isLinux {
    Unit = {
      Description = "Ulauncher application launcher";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.ulauncher}/bin/ulauncher --hide-window --no-window-shadow";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

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

      # Free up Super+Space (default: switch keyboard input source) so it can
      # be used for the Ulauncher toggle below.
      "org/gnome/desktop/wm/keybindings" = {
        switch-input-source = [ ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Ulauncher Toggle";
        command = "ulauncher-toggle";
        binding = "<Super>space";
      };
    };
  };
}
