{ config, ... }:
{
  services = {
    nginx = {
      enable = true;
      logError = "syslog:server=unix:/dev/log warn";
      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      recommendedOptimisation = true;
      resolver = {
        addresses = [
          "1.0.0.1"
          "1.1.1.1"
        ];
      };
    };
    adguardhome = {
      port = 3115;
      enable = true;
    };
  };
  networking = {
    firewall = {
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
          group = "nginx";
          extraDomainNames = [
            "*.sadan.zip"
          ];
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
