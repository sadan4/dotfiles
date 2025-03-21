{ inputs, pkgs, ... }:
let
  # KDE will show a bouncing icon whenever a command is started
  # this can be an issue for things like screenshot tools, which can capture those icons
  # Wrap in a nohup bash script to prevent this
  mkNoIconCommand =
    command:
    let
      inherit (builtins) hasAttr;
      logs = {
        enabled = true;
        identifier = "plasma-manager-commands-${command.name}";
        extraArgs = "";
      } // (if hasAttr "logs" command then command.logs else { });
      inherit (logs) extraArgs identifier enabled;
      finalCommand = command // {
        logs = logs // {
          enabled = false;
        };
        command = "${pkgs.writeShellScriptBin "nohupRunner-${identifier}" ''
          nohup ${
            if enabled then "${pkgs.systemd}/bin/systemd-cat --identifier=${identifier} ${extraArgs}" else ""
          } ${command.command} > /dev/null &
          exit 0
        ''}";
      };
    in
    finalCommand;
in
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
      shortcuts = {
        kwin = {
          "Window Quick Tile Top" = [ ];
          "Window Maximize" = [ "Meta+Up" ];
        };
      };
      hotkeys = {
        commands = {
          "ocr" = mkNoIconCommand {
            name = "OCR";
            key = "Meta+Shift+T";
            command = "frog -e";
          };
          "flameshot" = mkNoIconCommand {
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
