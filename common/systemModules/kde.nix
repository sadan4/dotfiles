{ pkgs, ... }:
{
  programs = {
    ssh = {
      askPassword = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    };
    gnupg = {
      agent = {
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
  };
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
