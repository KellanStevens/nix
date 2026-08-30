{ ... }:

{
  imports = [
    ./casks.nix
    ./formulae.nix
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };
}
