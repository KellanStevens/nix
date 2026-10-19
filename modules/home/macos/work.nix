# Home Manager settings only applied on the work Mac.
{ ... }:

{
  home.shellAliases = {
    sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";
    docker = "AWS_PROFILE=internal-services /opt/homebrew/bin/docker";
    static-analysis = "export PHPSTAN_MAX_PROCESSES=8 composer phpstan && composer phpmd";
    sp = "export PHPSTAN_MAX_PROCESSES=8 composer phpstan && composer phpmd && sail pint";
    satcf = "sail artisan test --compact --filter=";
    satc = "sail artisan test --compact";
    satf = "sail artisan test --filter=";
    sat = "sail artisan test";
    pa = "php artisan";
    pint = "sail pint";
  };
}
