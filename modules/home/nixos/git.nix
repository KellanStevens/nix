{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Sign commits with this machine's SSH key, like the Mac does with its own.
  # The key must also be added on GitHub as a *signing* key to show as Verified.
  programs.git = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
      # Lets `git log --show-signature` verify commits from both machines.
      allowedSigners = ''
        github@kellanstevens.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYA24+yEPHUEkXh8fK7jOiKj+sRo6ade6urvfMZojz7 nixos
        github@kellanstevens.com namespaces="git" ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGaZl4aI8q4/LSdvABWVesFV1GVaPlWarq1Bl2KbwKl mac
      '';
    };
  };
}
