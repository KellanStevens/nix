{ pkgs, ... }:

{
  home.username = "kellan";
  home.homeDirectory = "/home/kellan";

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

  # Interactive shell init
  programs.bash = {
    enable = true;
    initExtra = ''
      fastfetch
    '';
  };

  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;
}
