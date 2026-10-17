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
    rdp-nix = "sdl-freerdp /v:10.20.1.100 /u:kellan.stevens /dynamic-resolution /cert:tofu /from-stdin";
  };
}
