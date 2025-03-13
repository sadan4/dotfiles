{ ... }:
{
  imports = [
    ./nginx.nix
  ];
  services = {
    sonarr = {
        enable = true;
        group = "media";
        dataDir = "/storage/sonarrConf";
    };
  };
}
