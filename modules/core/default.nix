{ pkgs, ... }:

{
  # Enable Zsh system-wide
  programs.zsh.enable = true;

  # Nix settings & Automatic Garbage Collection (delete generations older than 10 days)
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Core system locale and time
  time.timeZone = "Africa/Johannesburg";
  i18n.defaultLocale = "en_ZA.UTF-8";
}
