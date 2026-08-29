{ ... }:

{
  # Ensure state directory exists for ACME certificate storage (/var/lib/traefik/acme.json)
  systemd.services.traefik.serviceConfig.StateDirectory = "traefik";

  services.traefik = {
    enable = true;

    # Path to environment file containing:
    # CF_DNS_API_TOKEN=your_cloudflare_api_token
    environmentFiles = [
      "/var/lib/traefik/cloudflare.env"
    ];

    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
            permanent = true;
          };
        };
        websecure = {
          address = ":443";
          http.tls = {
            certResolver = "cloudflare";
            domains = [
              {
                main = "local.kellanstevens.com";
                sans = [ "*.local.kellanstevens.com" ];
              }
            ];
          };
        };
      };

      certificatesResolvers = {
        cloudflare = {
          acme = {
            email = "admin@kellanstevens.com";
            storage = "/var/lib/traefik/acme.json";
            dnsChallenge = {
              provider = "cloudflare";
              resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
            };
          };
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          hassio = {
            rule = "Host(`hassio.local.kellanstevens.com`)";
            entryPoints = [ "websecure" ];
            service = "hassio-service";
            tls = {};
          };
        };

        services = {
          hassio-service = {
            loadBalancer = {
              servers = [
                {
                  url = "http://127.0.0.1:8123";
                }
              ];
            };
          };
        };
      };
    };
  };
}
