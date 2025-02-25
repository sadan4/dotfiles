
{ ... }:
{
  services = {
    nginx = {
      virtualHosts = {
        "obsidian.sadan.zip" = {
          forceSSL = true;
          useACMEHost = "sadan.zip";
          locations = {
            "/" = {
              proxyPass = "http://localhost:5984";
            };
          };
        };
      };
    };
  };
}
