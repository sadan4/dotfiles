{ config, ... }:
{
  sops = {
    secrets = {
      cfd = {
        format = "binary";
        sopsFile = ./cloudflared.pem;
      };
    };
  };
  services = {
    cloudflared = {
      tunnels = {
        "00000000-0000-0000-0000-000000000000" = {
          default = "http_status:404";
          ingress = {
            "*.sadan.zip" = "http://localhost:80";
          };
        };
      };
      certificateFile = config.sops.secrets.cfd.path;
    };
  };
}
