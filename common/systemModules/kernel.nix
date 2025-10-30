{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_6_16;
    kernel = {
      sysctl = {
        "kernel.sysrq" = 1;
        "fs.inotify.max_user_watches" = 1048576;
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
