{ NAME }: { ... }: {
  programs = {
    wireshark = {
      enable = true;
    };
  };
  users = {
    users = {
      "${NAME}" = {
        extraGroups = [
          "wireshark"
        ];
      };
    };
  };
}
