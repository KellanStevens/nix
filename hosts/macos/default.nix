{ pkgs, ... }:

{
  imports = [
    ../../modules/macos/homebrew
  ];

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

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.0;
        mru-spaces = false;
        show-recents = false;
        static-only = true;
        tilesize = 74;
      };

      finder = {
        AppleShowAllFiles = true;
        ShowPathbar = true;
        _FXEnableColumnAutoSizing = true;
      };

      trackpad = {
        TrackpadThreeFingerDrag = true;
      };

      NSGlobalDomain = {
        AppleKeyboardUIMode = 2;
        ApplePressAndHoldEnabled = false;
      };

      menuExtraClock.ShowSeconds = true;
    };
  };

  users.users."kellan.stevens" = {
    home = "/Users/kellan.stevens";
    shell = pkgs.zsh;
  };
}
