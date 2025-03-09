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
              proxyPass = "https://localhost:8989";
            };
          };
        };
      };
    };
  };
}
