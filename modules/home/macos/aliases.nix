{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  home.shellAliases = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    nix-rebuild = "sudo darwin-rebuild switch --flake ~/nix#${osConfig.networking.hostName}";
    brwup = "brew update -v && brew upgrade -v -g";
  };
}
