{ pkgs, ... }: {
  boot = {
    loader = {
      timeout = 0;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        efiInstallAsRemovable = true;
        timeoutStyle = "hidden";
      };
    };
  };
}
