{ pkgs, ... }: {
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        efiInstallAsRemovable = true;
      };
    };
  kernelPackages = pkgs.linuxPackages_latest;
  };
}
