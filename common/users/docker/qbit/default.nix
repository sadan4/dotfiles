{ config, ... }:
{
  imports = [
    ../../homeModules/sops.nix
  ];
  home = {
    file = {
      qbit_compose = {
        source = ./docker-compose.yml;
        target = "./src/qbit/docker-compose.yml";
      };
    };
  };
  sops = {
    secrets = {
      gluetun_env = {
        format = "dotenv";
        sopsFile = ./gluetun.env;
        path = "/home/${config.home.username}/src/qbit/gluetun.env";
      };
    };
  };
}
