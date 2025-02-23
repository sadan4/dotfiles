{ config, ... }:
{
  imports = [
    ../../homeModules/sops.nix
  ];
  home = {
    file = {
      vw = {
        source = ./docker_compose.nix;
        target = "./src/vw/docker_compose.yml";
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
      vw_backup = {
        format = "dotenv";
        sopsFile = ./backup.env;
        path = "/home/${config.home.username}/src/vw/backup.env";
      };
    };
  };
}
