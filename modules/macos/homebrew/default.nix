{ ... }:

{
  imports = [
    ./casks.nix
    ./formulae.nix
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
  };
}
