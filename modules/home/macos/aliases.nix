{ lib, pkgs, ... }:

{
  home.shellAliases = lib.mkIf pkgs.stdenv.isDarwin {
    nix-rebuild = "sudo darwin-rebuild switch --flake ~/nix#TL-FW21FX96ND";
    brwup = "brew update -v && brew upgrade -v -g";
    sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
    docker = "AWS_PROFILE=internal-services /opt/homebrew/bin/docker";
    static-analysis="export PHPSTAN_MAX_PROCESSES=8 composer phpstan && composer phpmd";
    sp="export PHPSTAN_MAX_PROCESSES=8 composer phpstan && composer phpmd && sail pint";
    aws-login="aws sso login --sso-session tillo-sso";
    satcf="sail artisan test --compact --filter=";
    satc="sail artisan test --compact";
    satf="sail artisan test --filter=";
    sat="sail artisan test";
    pa = "php artisan";
    pint="sail pint";
  };
}
