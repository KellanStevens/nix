{ lib, pkgs, ... }:

{
  home.shellAliases = lib.mkIf pkgs.stdenv.isDarwin {
    nix-rebuild = "sudo darwin-rebuild switch --flake ~/nix#TL-FW21FX96ND";
  };
}
