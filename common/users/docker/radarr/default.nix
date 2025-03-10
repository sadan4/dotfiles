
{ ... }:
{
  home = {
    file = {
      sonarr_compose = {
        source = ./docker-compose.yml;
        target = "./src/radarr/docker-compose.yml";
      };
    };
  };
}
