{ lib, pkgs, ... }:

{
  dconf = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      scaling-factor = lib.hm.gvariant.mkUint32 2;
    };
  };
}
