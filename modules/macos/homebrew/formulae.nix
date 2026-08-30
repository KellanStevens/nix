{ ... }:

{
  homebrew = {
    taps = [
      "atlassian/acli"
      "hashicorp/tap"
      "jandedobbeleer/oh-my-posh"
      "jundot/omlx"
      "oven-sh/bun"
    ];

    brews = [
      "atlassian/acli/acli"
      "awscli"
      "bat"
      "bpytop"
      "brightness"
      "circleci"
      "cloudflared"
      "colima"
      "composer"
      "dnsmasq"
      "docker"
      "docker-buildx"
      "docker-compose"
      "docker-credential-helper"
      "docker-credential-helper-ecr"
      "eza"
      "fastfetch"
      "fzf"
      "gh"
      "git"
      "hashicorp/tap/terraform"
      "jandedobbeleer/oh-my-posh/oh-my-posh"
      "jundot/omlx/omlx"
      "kubernetes-cli"
      "lazydocker"
      "lazygit"
      "mago"
      "mysql@8.4"
      "neovim"
      "oven-sh/bun/bun"
      "php@8.2"
      "rabbitmq-c"
      "ripgrep"
      "rust"
      "tmux"
      "volta"
      "zoxide"
    ];
  };
}
