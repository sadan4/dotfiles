{ inputs, config, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    # TODO: import dynamically based on hostname
    ./displays/nix-desktop-evo4b5.nix
  ];
  # workaround https://github.com/nix-community/plasma-manager/issues/472
  # This errors
  # home.file.".gtkrc-2.0".force = true;
  gtk.gtk2.configLocation = "${config.home.homeDirectory}/.config/.gtkrc-2.0";
  programs = {
    plasma = {
      enable = true;
      overrideConfig = true;
      # input.mice is only on a per-mouse basis and doesnt have these settings
      configFile = {
        "kcminputrc" = {
          Mouse = {
            X11LibInputXAccelProfileFlat = true;
            XLbInptAccelProfileFlat = true;
          };
        };
      };
      # Needed because our color scheme is overwritten
      workspace = {
        colorScheme = "TokyoNight";
        # sleeping cat, installed from marketplace
        # TODO: declaratively install things from the marketplace
        splashScreen = {
          theme = "a2n.kuro";
        };
      };
      hotkeys = {
        commands = {
          "ocr" = {
            name = "OCR";
            key = "Meta+Shift+T";
            command = "frog -e";
          };
          "flameshot" = {
            name = "flameshot";
            key = "Print";
            command = "flameshot gui";
          };
          "rofi" = {
            name = "rofi";
            key = "Alt+P";
            command = "rofi -show drun";
          };
          "kitty" = {
            name = "kitty";
            key = "Alt+Shift+Return";
            command = "kitty";
          };
        };
      };
    };
  };
}
