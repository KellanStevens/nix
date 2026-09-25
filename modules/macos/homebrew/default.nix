{ ... }:

{
  imports = [
    ./casks.nix
    ./formulae.nix
  ];

  homebrew = {
    enable = true;
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
  };
}
