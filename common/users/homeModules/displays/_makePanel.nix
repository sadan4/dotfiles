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
