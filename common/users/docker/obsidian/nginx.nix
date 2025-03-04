{ ... }:
{
  services = {
    nginx = {
      virtualHosts = {
        "obsidian.sadan.zip" = {
          extraConfig = ''
            client_max_body_size 1000M;
          '';
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
