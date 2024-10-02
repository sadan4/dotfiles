{ ... }: {
  services = {
    desktopManager = {
      plasma6 = {
        enable = true;
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          autoNumlock = true;
          wayland = {
            enable = false;
          };
        };
      };
    };
  };
}
