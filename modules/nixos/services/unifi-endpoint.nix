{ inputs, pkgs, ... }:

# Uses the module + package from the pending nixpkgs PR. Once it reaches
# nixpkgs-unstable, drop the flake input and keep only
# `programs.unifi-endpoint.enable = true;`.
let
  pr = inputs.nixpkgs-unifi-endpoint;
in
{
  imports = [ "${pr}/nixos/modules/programs/unifi-endpoint.nix" ];

  # Testing the module under AppArmor for the nixpkgs PR review.
  security.apparmor.enable = true;

  programs.unifi-endpoint = {
    enable = true;
    package =
      (import pr {
        inherit (pkgs.stdenv.hostPlatform) system;
        config.allowUnfree = true;
      }).unifi-endpoint;
  };
}
