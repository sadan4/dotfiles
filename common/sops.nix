{ config }:
{
  age.keyFile = "/home${config.home.username}/.config/sops/age/keys.txt";
  defaultSopsFile = ../../secrets.yaml;
  secrets.hosts = {
    format = "binary";
    sopsFile = ../../secrets/hosts;
    owner = "${config.home.username}"
      };
  }
