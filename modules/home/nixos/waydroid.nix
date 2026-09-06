{ lib, pkgs, ... }:

{
  # Waydroid's container is already started system-wide by the
  # `waydroid-container` service; this brings up the per-user Wayland
  # session (needed for Android app windows) as soon as the graphical
  # session is available, so it's ready without running `waydroid session
  # start` by hand.
  systemd.user.services.waydroid-session = lib.mkIf pkgs.stdenv.isLinux {
    Unit = {
      Description = "Waydroid session";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.waydroid}/bin/waydroid session start";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
