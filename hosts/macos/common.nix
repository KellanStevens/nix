# Shared nix-darwin settings for every Mac. Host-specific bits live in
# hosts/macos/<host>/default.nix.
{ pkgs, ... }:

{
  imports = [
    ../../modules/macos/homebrew
    ../../modules/tailscale.nix
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
