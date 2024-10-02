{ config, inputs, ... }:
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = {
    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../../secrets.yaml;
    secrets.hosts = {
      format = "binary";
      sopsFile = ../../../secrets/hosts;
      path = "/home/${config.home.username}/.config/gh/hosts.yml";
    };
  };
}
