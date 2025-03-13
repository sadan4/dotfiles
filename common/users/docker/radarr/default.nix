
{ ... }:
{
  imports = [
    ./nginx.nix
  ];
  services = {
    radarr = {
        enable = true;
        dataDir = "/storage/radarrConf";
        group = "media";
    };
  };
}
