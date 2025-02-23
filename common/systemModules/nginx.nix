{ config, ... }:
{
  services = {
    nginx = {
      user = "root";
      enable = true;
      logError = "syslog:warn";
      statusPage = true;
    };
  };
  sops = {
    secrets = {
      cloudflare_env = {
        format = "dotenv";
        sopsFile = ./cloudflare.env;
      };
    };
  };
  security = {
    acme = {
      certs = {
        "*.sadan.zip" = {
          dnsProvider = "cloudflare";
          email = "certs@sadan.zip";
          environmentFile = config.sops.secrets.cloudflare_env.path;
        };
      };
      acceptTerms = true;
    };
  };
}
