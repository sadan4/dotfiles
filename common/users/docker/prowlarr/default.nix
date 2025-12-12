{ pkgs, config, lib, ... }:
let 
    dataDir = "/storage/prowlarrConf";
in
{
  imports = [
    ./nginx.nix
  ];
  # I would just use services.prowlarr, but the implementation in nixpkgs is evil and 
  # loves randomly changing ownership of it's data files, erroring the server
  services = {
    prowlarr = {
      enable = false;
      inherit dataDir;
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
        description = "Prowlarr";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        environment = {
            PROWLARR__LOG__ANALYTICSENABLED = "false";
            PROWLARR__SERVER__PORT = "9696";
            PROWLARR__UPDATE__AUTOMATICALLY = "false";
            PROWLARR__UPDATE__MECHANISM = "external";
        };
        serviceConfig = {
            Type = "simple";
            DynamicUser = false;
            User = config.users.users.prowlarr.name;
            ExecStart = "${lib.getExe pkgs.prowlarr} -nobrowser -data=${dataDir}";
            Restart = "on-failure";
        };
      };
    };
    tmpfiles = {
        settings = {
            "10-prowlarr" = {
                "${dataDir}" = {
                    Z = {
                        user = config.users.users.prowlarr.name;
                        group = config.users.groups.media.name;
                        mode = "-";
                    };
                };
            };
        };
    };
  };
}
