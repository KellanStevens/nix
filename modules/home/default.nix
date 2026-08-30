{ pkgs, ... }:

{
  imports = [
    ./aliases.nix
    ./oh-my-posh.nix
  ];

  home.username = "kellan.stevens";
  home.homeDirectory = "/home/kellan.stevens";

  # User packages
  home.packages = with pkgs; [
    firefox
    git
    vim
    tmux
    eza
    fzf
    oh-my-posh
    stremio-linux-shell
    fastfetch
    wget
    nixfmt
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
