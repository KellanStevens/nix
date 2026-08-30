{ lib, pkgs, ... }:

{
  programs.zsh.initContent = lib.mkIf pkgs.stdenv.isDarwin (
    lib.mkAfter ''
      bindkey -e
      bindkey '\e\e[C' forward-word
      bindkey '\e\e[D' backward-word
    ''
  );
}
