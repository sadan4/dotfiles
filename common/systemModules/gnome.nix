{ pkgs, ... }:
{
  services = {
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
      desktopManager = {
        gnome = {
          enable = true;
        };
      };
      enable = true;
    };
  };
}
