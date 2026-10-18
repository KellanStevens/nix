# Personal MacBook.
{ ... }:

{
  imports = [
    ../common.nix
    ../../../modules/macos/homebrew/personal.nix
  ];

  networking.hostName = "macbook-pro";
}
