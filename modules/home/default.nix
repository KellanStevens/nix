{ pkgs, lib, ... }:

{
  imports = [
    ./aliases.nix
    ./oh-my-posh.nix
  ];

  home.username = "kellan";
  home.homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/kellan" else "/home/kellan";

  # Cross-platform packages
  home.packages = with pkgs; [
    git
    vim
    tmux
    eza
    fzf
    oh-my-posh
    fastfetch
    wget
    nixfmt
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    firefox
    stremio-linux-shell
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

  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;
}
