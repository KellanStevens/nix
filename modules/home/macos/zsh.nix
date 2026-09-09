{ lib, pkgs, ... }:

{
  programs.zsh.initContent = lib.mkIf pkgs.stdenv.isDarwin (
    lib.mkAfter ''
      export PATH="/opt/homebrew/opt/rustup/bin:$HOME/.local/bin:$PATH"

      bindkey -e
      bindkey '\e\e[C' forward-word
      bindkey '\e\e[D' backward-word
    ''
  );
}
