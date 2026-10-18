# Shared nix-darwin settings for every Mac. Host-specific bits live in
# hosts/macos/<host>/default.nix.
{ pkgs, ... }:

{
  imports = [
    ../../modules/macos/homebrew
  ];

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
        # No pinned apps, so the dock only shows running apps. static-only
        # would do the same but also hides the Downloads stack.
        static-only = false;
        persistent-apps = [ ];
        persistent-others = [
          {
            folder = {
              path = "/Users/kellan.stevens/Downloads";
              arrangement = "date-added";
              displayas = "stack";
            };
          }
        ];
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

      # Menu bar items besides the clock and Control Center. Wi-Fi has no
      # option here and is shown by default.
      controlcenter = {
        Bluetooth = true;
        Sound = true;
        BatteryShowPercentage = true;
        AirDrop = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
      };
    };
  };

  users.users."kellan.stevens" = {
    home = "/Users/kellan.stevens";
    shell = pkgs.zsh;
  };
}
