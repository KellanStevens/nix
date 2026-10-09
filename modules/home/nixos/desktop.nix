{ lib, pkgs, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
    pkgs.vscode
    pkgs.github-desktop
  ];

  # Headless Plasma X11 session served over VNC for macOS Screen Sharing
  # (vnc://<host>:5900). The machine has no screen or console session, so this is
  # the only desktop. Create the password once with:
  #   mkdir -p ~/.vnc && vncpasswd -f > ~/.vnc/passwd && chmod 600 ~/.vnc/passwd
  systemd.user.services.vnc-plasma = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    Unit = {
      Description = "Plasma X11 session over VNC (TigerVNC)";
      ConditionPathExists = "%h/.vnc/passwd";
    };
    Service = {
      ExecStart = pkgs.writeShellScript "vnc-plasma" ''
        export XDG_SESSION_TYPE=x11 XDG_CURRENT_DESKTOP=KDE KDE_FULL_SESSION=true
        unset WAYLAND_DISPLAY DISPLAY
        ${pkgs.tigervnc}/bin/Xvnc :10 -rfbport 5900 -rfbauth "$HOME/.vnc/passwd" \
          -SecurityTypes VncAuth -geometry 1920x1200 -depth 24 -AlwaysShared &
        xvnc=$!
        trap 'kill $xvnc' EXIT
        sleep 2
        export DISPLAY=:10
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.kdePackages.plasma-workspace}/bin/startplasma-x11
      '';
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
