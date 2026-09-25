{ lib, pkgs, ... }:

{
  programs.zsh.initContent = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (
    lib.mkAfter ''
      eval "$(/opt/homebrew/bin/brew shellenv zsh)"
      export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.local/bin:$PATH"

      bindkey -e
      bindkey '\e\e[C' forward-word
      bindkey '\e\e[D' backward-word
    ''
  );
}
