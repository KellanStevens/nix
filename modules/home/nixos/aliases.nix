{ lib, pkgs, ... }:

{
  home.shellAliases = lib.mkIf pkgs.stdenv.isLinux {
    nix-rebuild = "sudo nixos-rebuild switch --flake ~/nix#nixos";
  };
}
