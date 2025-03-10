{ ... }:
{
  home = {
    file = {
      prowlarr_compose = {
        source = ./docker-compose.yml;
        target = "./src/prowlarr/docker-compose.yml";
      };
    };
  };
}
