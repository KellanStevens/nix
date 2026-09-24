{ lib, pkgs, ... }:

{
  home.shellAliases = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    nix-rebuild = "sudo nixos-rebuild switch --flake ~/nix#nixos";
  };
}
