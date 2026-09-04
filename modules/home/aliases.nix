{ ... }:

{
  home.shellAliases = {
    ls = "eza --icons --group-directories-first";
    ll = "eza --icons --group-directories-first -l";
    la = "eza --icons --group-directories-first -la";

    grep = "grep --color";

    cat = "bat";
  };
}
