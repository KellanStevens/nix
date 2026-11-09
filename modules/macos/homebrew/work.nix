# Homebrew packages only installed on the work Mac.
{ ... }:

{
  homebrew = {
    taps = [
      "atlassian/acli"
      "datadog-labs/pack"
      "hashicorp/tap"
      "oven-sh/bun"
    ];

    brews = [
      "atlassian/acli/acli"
      "awscli"
      "colima"
      "composer"
      "dnsmasq"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "docker-credential-helper-ecr"
      "freerdp"
      "hashicorp/tap/terraform"
      "kubernetes-cli"
      "lazydocker"
      "mysql@8.4"
      "oven-sh/bun/bun"
      "php@8.2"
      "datadog-labs/pack/pup"
      "rabbitmq-c"
      "volta"
    ];

    casks = [
      "cmux"
      "tableplus"
    ];
  };
}
