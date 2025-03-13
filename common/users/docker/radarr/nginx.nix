

{ ... }:
{
  services = {
    flaresolverr = {
        enable = true;
    };
    nginx = {
      virtualHosts = {
        "radarr.sadan.zip" = {
          forceSSL = true;
          useACMEHost = "sadan.zip";
          locations = {
            "/" = {
              proxyPass = "http://localhost:9696";
            };
          };
        };
      };
    };
  };
}
