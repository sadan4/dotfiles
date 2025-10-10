{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_16;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;
      };
    };
  };
  services = {
    earlyoom = {
      enable = true;
      enableNotifications = true;
    };
  };
}
