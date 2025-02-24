{ config, ... }:
{
  services = {
    nginx = {
      enable = true;
      # logError = "syslog:server=unix:/dev/log warn";
      statusPage = true;
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedOptimisation = true;
    };
    adguardhome = {
      port = 3115;
      enable = true;

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
        "sadan.zip" = {
          dnsProvider = "cloudflare";
          email = "certs@sadan.zip";
          environmentFile = config.sops.secrets.cloudflare_env.path;
        };
      };
      defaults = {
        # If the local dns server hasnt started yet, then this will fail for any domain configured with tailscale magic dns
        dnsResolver = "1.1.1.1:53";
      };
      acceptTerms = true;
    };
  };
}
