{ NAME }:
{ ... }:
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
    };
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };
}
