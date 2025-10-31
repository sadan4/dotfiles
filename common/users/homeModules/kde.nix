{ pkgs, ... }:
{
  imports = [
    ./plasma.nix
  ];
  home = {
    packages = with pkgs; [
      kdePackages.filelight
      kdePackages.ksshaskpass
      kdePackages.kfind
      xsel
      xorg.xkill
      xorg.xprop
      xorg.xwininfo
      xdotool
      kdePackages.kcolorchooser
      qalculate-qt
      gnome-disk-utility
      kdePackages.plasma-browser-integration
      xmacro
      bitwarden-desktop
    ];
  };
  programs = {
    plasma = {
      hotkeys = {
        commands = {
          "xkill" = {
            name = "xkill";
            key = "Ctrl+Shift+K";
            command = "xkill";
          };
        };
      };
    };
  };
}
