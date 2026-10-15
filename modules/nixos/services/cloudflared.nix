{ pkgs, ... }:

{
  # Remotely-managed Cloudflare Tunnel: ingress rules (public hostnames) are
  # configured in the Cloudflare Zero Trust dashboard, not here.
  systemd.services.cloudflared = {
    description = "Cloudflare Tunnel";
    after = [ "network-online.target" "tailscaled.service" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      # Path to environment file containing:
      # TUNNEL_TOKEN=your_tunnel_token
      EnvironmentFile = "/var/lib/cloudflared/tunnel.env";
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      DynamicUser = true;
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
