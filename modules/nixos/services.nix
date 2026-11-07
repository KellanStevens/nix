{ ... }:

{
  # Services shared by every NixOS host.
  imports = [
    ./services/nix-ld.nix
    ./services/ssh.nix
  ];
}
