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
        format = "env";
        sopsFile = ./vw.env;
        path = "/home/${config.home.username}/src/vw/vw.env";
      };
      vw_backup = {
        format = "env";
        sopsFile = ./backup.env;
        path = "/home/${config.home.username}/src/vw/backup.env";
      };
    };
  };
}
