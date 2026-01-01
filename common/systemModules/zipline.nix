{config, ...}: {
    sops = {
        secrets = {
            zipline = {
                # plaintext, but same difference
                format = "binary";
                sopsFile = ./ziplineSecret.txt;
            };
        };
    };
    services = {
        zipline = {
            enable = true;
            settings = {
                DATASOURCE_TYPE = "local";
                DATASOURCE_LOCAL_DIRECTORY = "${config.fileSystems."/storage".mountPoint}/zipline";
                CORE_HOSTNAME = "0.0.0.0";
                CORE_PORT = 6767;
                CORE_SECRET_FILE = config.sops.secrets.zipline.path;
                CORE_SECRET = "uZoeYs0k5X3Pw7NTJ1ItChYNBEhQY9PyPktLFUuKHPmV7wjQaqUx4j8MEdPh";
            };
        };
        nginx = {
            virtualHosts = {
                "host.sadan.zip" = {
                    forceSSL = true;
                    useACMEHost = "sadan.zip";
                    locations = {
                        "/" = {
                            proxyPass = "http://localhost:6767";
                            proxyWebsockets = true;
                        };
                    };
                };
            };
        };
    };
}