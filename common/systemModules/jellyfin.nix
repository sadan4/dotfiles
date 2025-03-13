{ config, ... }:
{
  users = {
    groups = {
      media = {
        gid = 1002;
      };
    };
  };
  services = {
    jellyfin = {
      dataDir = "${config.fileSystems."/storage".mountPoint}/jfData/";
      group = "media";
      enable = true;
      openFirewall = true;
    };
  };
  services = {
    nginx = {
      virtualHosts = {
        "jf.sadan.zip" = {
          forceSSL = true;
          useACMEHost = "sadan.zip";
          locations = {
            "/" = {
              proxyPass = "http://localhost:8096";
              proxyWebsockets = true;
            };
          };
        };
      };
    };
  };
}
