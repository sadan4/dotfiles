{ inputs, pkgs, ... }:
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
    # TODO: import dynamically based on hostname
    ./displays/nix-desktop-evo4b5.nix
  ];
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
        # Stylix will write to `~/.gtkrc-2.0`, but KDE has a daemon that will auto-generate a gtk config for the theme in use
        "kded5rc" = {
          Module-gtkconfig = {
            autoload = false;
          };
        };
        # KDE will add a bouncing cursor to commands launched from hotkeys
        # which gets in the way of anything launched from a hotkey that uses the display
        "klaunchrc" = {
          BusyCursorSettings = {
            Bouncing = false;
          };
          FeedbackStyle = {
            BusyCursor = false;
            # Annoying blank file icon in the taskbar while a command is running
            TaskbarButton = false;
          };
        };
        "kwinrc" = {
          MouseBindings = {
            CommandAllWheel = "Maximize/Restore";
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
        wallpaper = ../../../dotfiles/wallpaper.jpg;
      };
      # Dont open apps from last session (can lead to tons of random things bloating startup times)
      session = {
        sessionRestore = {
          restoreOpenApplicationsOnLogin = "startWithEmptySession";
        };
      };
      kwin = {
        titlebarButtons = {
          left = [
            "keep-above-windows"
          ];
          right = [
            "minimize"
            "maximize"
            "close"
          ];
        };
      };
      shortcuts = {
        kwin = {
          "Window Quick Tile Top" = [ ];
          "Window Maximize" = [ "Meta+Up" ];
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
  stylix = {
    targets = {
      kde = {
        enable = false;
      };
    };
  };
}
