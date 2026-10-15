{ lib, pkgs, ... }:

let
  # nixpkgs' t3code sets dontPatchELF and ships npm's generic-Linux prebuilt
  # native modules untouched, so they can't find libstdc++ (or libxkbcommon)
  # on NixOS. node-pty failing to load kills the backend and the window never
  # opens. Drop once fixed upstream.
  t3code = pkgs.t3code.override {
    t3code-unwrapped = pkgs.t3code.unwrapped.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        find "$out"/libexec/t3code/node_modules/.pnpm -name '*.node' -path '*linux-x64*' ! -name '*musl*' \
          -exec patchelf --add-rpath ${
            lib.makeLibraryPath [
              pkgs.stdenv.cc.cc.lib
              pkgs.libxkbcommon
            ]
          } {} \;
      '';
    });
    # Same source either way; reuse the cached sidecar instead of rebuilding it.
    t3code-resource-monitor = pkgs.t3code.resourceMonitor;
  };
in
{
  home.packages = lib.mkIf pkgs.stdenv.hostPlatform.isLinux [
    pkgs.vscode
    pkgs.github-desktop
    t3code
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
