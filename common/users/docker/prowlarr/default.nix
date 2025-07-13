{ ... }:
{
  imports = [
    ./nginx.nix
  ];
  services = {
    prowlarr = {
      enable = true;
      dataDir = "/storage/prowlarrConf";
    };
  };
  systemd = {
    services = {
      prowlarr = {
        serviceConfig = {
          Group = "media";
        };
      };
    };
  };
}
