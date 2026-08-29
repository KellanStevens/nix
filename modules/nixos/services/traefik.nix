{ ... }:

{
  services.traefik = {
    enable = true;

    staticConfigOptions = {
      entryPoints = {
        web = {
          address = ":80";
        };
        websecure = {
          address = ":443";
        };
      };
    };

    dynamicConfigOptions = {
      http = {
        routers = {
          hassio = {
            rule = "Host(`hassio.local.kellanstevens.com`)";
            entryPoints = [ "web" "websecure" ];
            service = "hassio-service";
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
