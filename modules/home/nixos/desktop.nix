{ lib, pkgs, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
    pkgs.vscode
    pkgs.ulauncher
    pkgs.github-desktop
  ];

  # Spotlight-style app launcher. Its own hotkey grab doesn't work under Wayland,
  # so bind Super+Space to `ulauncher-toggle` in Plasma's Shortcuts settings.
  systemd.user.services.ulauncher = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
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

}
