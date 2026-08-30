{ pkgs, ... }:

{
  networking.hostName = "TL-FW21FX96ND";

  nix.enable = false;
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  programs.zsh.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = "kellan.stevens";
    stateVersion = 7;
  };

  users.users."kellan.stevens" = {
    home = "/Users/kellan.stevens";
    shell = pkgs.zsh;
  };
}
