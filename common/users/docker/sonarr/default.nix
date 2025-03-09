{ config, ... }:
{
  imports = [
    ../../homeModules/sops.nix
  ];
  home = {
    file = {
      sonarr_compose = {
        source = ./docker-compose.yaml;
        target = "./src/sonarr/docker-compose.yml";
      };
    };
  };
}
