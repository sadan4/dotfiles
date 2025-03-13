{ ... }:
{
  services = {
    nginx = {
      virtualHosts = {
        "sonarr.sadan.zip" = {
          forceSSL = true;
          useACMEHost = "sadan.zip";
          locations = {
            "/" = {
              proxyPass = "http://localhost:8989";
              proxyWebsockets = true;
            };
          };
        };
      };
    };
  };
}
