{ pkgs, config, ... }:
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
  users = {
    users = {
        prowlarr = {
            isNormalUser = true;
            shell = "${pkgs.util-linux}/bin/nologin";
            extraGroups = [
                config.users.groups.media.name
            ];
        };
    };
  };
  systemd = {
    services = {
      prowlarr = {
        serviceConfig = {
          Group = "media";
          User = config.users.users.prowlarr.name;
        };
      };
    };
  };
}
