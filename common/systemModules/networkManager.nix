{ NAME }: { ... }: {
  users = {
    users = {
      "${NAME}" = {
        extraGroups = [
          "networkmanager"
        ];
      };
    };
  };
  networking = {
    networkmanager = {
      enable = true;
    };
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };
}
