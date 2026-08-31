{ lib, pkgs, ... }:

{
  programs.zsh.initContent = lib.mkIf pkgs.stdenv.isDarwin (
    lib.mkAfter ''
      export PATH="$HOME/.local/bin:$PATH"

      bindkey -e
      bindkey '\e\e[C' forward-word
      bindkey '\e\e[D' backward-word
    ''
  );
}
