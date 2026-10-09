{ lib, pkgs, ... }:

{
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
    pkgs.vscode
    pkgs.github-desktop
  ];

  # The headless GNOME session is served over RDP by gnome-remote-desktop (see
  # modules/nixos/desktop.nix). Give it a TLS certificate and login once with:
  #   mkdir -p ~/.local/share/gnome-remote-desktop && cd $_
  #   nix shell nixpkgs#openssl -c openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
  #     -subj "/CN=$(hostname)" -keyout rdp-tls.key -out rdp-tls.crt
  #   grdctl --headless rdp set-tls-key ~/.local/share/gnome-remote-desktop/rdp-tls.key
  #   grdctl --headless rdp set-tls-cert ~/.local/share/gnome-remote-desktop/rdp-tls.crt
  #   grdctl --headless rdp set-credentials <username> <password>
  #   grdctl --headless rdp disable-view-only
  #   grdctl --headless rdp enable
  # Start the RDP server with this user's GNOME session only, not the login
  # screen's (the same link `systemctl --user enable` would make).
  xdg.configFile."systemd/user/gnome-session.target.wants/gnome-remote-desktop-headless.service" =
    lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      source = "${pkgs.gnome-remote-desktop}/lib/systemd/user/gnome-remote-desktop-headless.service";
    };
}
