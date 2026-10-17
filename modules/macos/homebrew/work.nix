# Homebrew packages only installed on the work Mac.
{ ... }:

{
  homebrew = {
    taps = [
      "atlassian/acli"
      "hashicorp/tap"
    ];

    brews = [
      "atlassian/acli/acli"
      "awscli"
      "composer"
      "dnsmasq"
      "docker-credential-helper-ecr"
      "hashicorp/tap/terraform"
      "kubernetes-cli"
      "mysql@8.4"
      "php@8.2"
      "rabbitmq-c"
    ];

    casks = [
      "tableplus"
    ];
  };
}
