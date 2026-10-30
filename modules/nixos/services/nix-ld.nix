{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    glib
    nspr
    nss
    atk
    at-spi2-atk
    at-spi2-core
    dbus
    expat
    libxkbcommon
    libgbm
    systemd
    libx11
    libxcb
    libxcomposite
    libxdamage
    libxext
    libxfixes
    libxrandr
    alsa-lib
    cups
    pango
    cairo
  ];
}
