{ pkgs, ... }:
{
  imports = [
    ./plasma.nix
  ];
  home = {
    packages = with pkgs; [
      kdePackages.filelight
      kdePackages.ksshaskpass
      xsel
      xorg.xkill
      xorg.xprop
      xorg.xwininfo
      kdePackages.kcolorchooser
      qalculate-qt
      gnome-disk-utility
      kdePackages.plasma-browser-integration
      xmacro
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
