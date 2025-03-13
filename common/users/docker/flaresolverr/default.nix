{...}: {
    home = {
        file = {
            flaresolverr_compose = {
                source = ./docker-compose.yml;
                target = "./src/flaresolverr/docker-compose.yml";
            };
        };
    };
}
