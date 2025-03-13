{...}: {
    home = {
        file = {
            source = ./docker-compose.yml;
            target = "./src/flaresolverr/docker-compose.yml";
        };
    };
}
