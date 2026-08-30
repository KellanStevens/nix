{ lib, pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./macos/aliases.nix
    ./nixos/aliases.nix
    ./nixos/desktop.nix
    ./oh-my-posh.nix
  ];

  home.username = "kellan.stevens";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/kellan.stevens" else "/home/kellan.stevens";

  # User packages
  home.packages =
    (with pkgs; [
      git
      vim
      tmux
      eza
      fzf
      oh-my-posh
      fastfetch
      wget
      nixfmt
    ])
    ++ lib.optionals pkgs.stdenv.isLinux [
      pkgs.stremio-linux-shell
    ];

  # Interactive Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      fastfetch
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;
}
