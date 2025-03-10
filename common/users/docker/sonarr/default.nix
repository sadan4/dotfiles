{ ... }:
{
  home = {
    file = {
      sonarr_compose = {
        source = ./docker-compose.yml;
        target = "./src/sonarr/docker-compose.yml";
      };
    };
  };
}
