{ ... }:

{
  home.shellAliases = {
    ls = "eza --icons --group-directories-first";
    ll = "eza --icons --group-directories-first -l";
    la = "eza --icons --group-directories-first -la";

    grep = "grep --color";

    cat = "bat";

    # Nix store cleanup - identical on NixOS and nix-darwin.
    nix-gc = "sudo nix-collect-garbage -d";
    nix-optimise = "sudo nix-store --optimise";
    nix-clean = "nix-gc && nix-optimise";
  };
}
