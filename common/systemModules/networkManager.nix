{ NAME }:
{ pkgs, ... }:
{
  users = {
    users = {
      "${NAME}" = {
        extraGroups = [
          "networkmanager"
        ];
      };
    };
  };
  systemd = {
    network = {
      wait-online = {
        enable = false;
      };
    };
  };
  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
