{config, ...}: {
    users = {
        groups = {
            media = {
                gid = 1002;
            };
        };
    };
    services = {
        jellyfin = {
            dataDir = "${config.fileSystems."/storage".mountPoint}/jfData/";
            group = "media";
            enable = true;
        };
    };
    services = {
        nginx = {
            virtualHosts = {
                "jf.sadan.zip" = {
                    forceSSL = true;
                    useACMEHost = "sadan.zip";
                    locations = {
                        "/" = {
                            proxyPass = "http://localhost:8096";
                            extraConfig = ''
                                proxy_http_version 1.1;
                                proxy_set_header Upgrade $http_upgrade;
                                proxy_set_header Connection $http_connection;
                            '';
                        };
                    };
                };
            };
        };
    };
}
