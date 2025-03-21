{ config, ... }:
{
  imports = [
    ../../homeModules/sops.nix
  ];
  home = {
    file = {
      vw = {
        source = ./docker_compose.yaml;
        target = "./src/vw/docker-compose.yaml";
      };
    };
  };
  systemd = {
    user = {
      tmpfiles = {
        rules = [
          "C /home/${config.home.username}/src/vw/rclone-config/rclone/rclone.conf 0444 - - 0 ${config.sops.secrets.rclone_config_file.path}"
        ];
      };
    };
  };

  sops = {
    secrets = {
      vw = {
        format = "dotenv";
        sopsFile = ./vw.env;
        path = "/home/${config.home.username}/src/vw/vw.env";
      };
      rclone_config_file = {
        format = "binary";
        sopsFile = ./rclone.conf;
      # path = "/home/${config.home.username}/src/vw/rclone-config/rclone/rclone.conf";
      };
      vw_backup = {
        format = "dotenv";
        sopsFile = ./backup.env;
        path = "/home/${config.home.username}/src/vw/backup.env";
      };
    };
  };
}
