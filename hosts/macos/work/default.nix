# Work MacBook.
{ ... }:

{
  imports = [
    ../common.nix
    ../../../modules/macos/homebrew/work.nix
  ];

  networking.hostName = "TL-FW21FX96ND";
}
