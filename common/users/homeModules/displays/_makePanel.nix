{ screen }:
let
  baseConfig = {
    inherit screen;
    floating = true;
    height = 40;
    # weird, see: https://github.com/nix-community/plasma-manager/issues/62#issuecomment-1986816749
    hiding = "normalpanel";
    lengthMode = "fit";
    location = "top";
    maxLength = null;
    minLength = null;
    offset = null;
    opacity = "opaque";
  };
in
builtins.map (section: baseConfig // section) [
  {
    alignment = "left";
    widgets = [
      {
        kicker = {
          icon = "nix-snowflake-white";
        };
      }
      {
        appMenu = {
        };
      }
    ];
  }
  {
    alignment = "center";
    widgets = [
      {
        iconTasks = {
          # .desktop filenames
          # 1. open app
          # 2. drag app to desktop => copy here
          # 3. open context menu => show target
          # 4. copy filename
          # 5. profit
          launchers = builtins.map (filename: "applications:${filename}.desktop") [
            "brave-browser"
            "spotify"
            "kitty"
            "vesktop"
          ];
          appearance = {
            fill = false;
          };
        };
      }
    ];
  }
  {
    alignment = "right";
    widgets = [
      {
        systemTray = {
          icons = {
            spacing = "small";
          };
          items = {
            hidden = [
              "flameshot"
              # razer keybord lighting
              "polychromatic-tray-applet"
              "spotify-client"
              # Electron apps all have the same id, see: https://github.com/electron/electron/issues/40936
              # better to just filter them all out
              "chrome_status_icon_1"
              "org.kde.plasma.brightness"
              # keyboard lang
              "org.kde.plasma.keyboardlayout"
              # caps lock, etc...
              "org.kde.plasma.keyboardindicator"
              # I would like for this to only show if sleep is being inhibited
              # but it shows anytime the power profile is not the default
              "org.kde.plasma.battery"
              # I think this shows anytime you're saving clipboard history why???
              "org.kde.plasma.clipboard"
              # shows any time **any** media is playing or paused in the background
              "org.kde.plasma.mediacontroller"
              # always shown while notifications are enabled
              "org.kde.plasma.notifications"
            ];
            shown = [
              "org.kde.plasma.volume"
              "org.kde.plasma.networkmanagement"
            ];
          };
        };
      }
      {
        digitalClock = {
          time = {
            format = "12h";
          };
        };
      }
    ];
  }
]
