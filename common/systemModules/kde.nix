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
    displayManager = {
      sddm = {
        wayland = {
          enable = false;
        };
        enable = true;
        autoNumlock = true;
      };
    };
    xserver = {
      enable = true;
    };
  };
}
