{ ... }:
let
  makePanel = import ./_makePanel.nix;
in
{
  programs = {
    plasma = {
      panels =
        [ ] ++ (makePanel { screen = 0; }) ++ (makePanel { screen = 1; }) ++ (makePanel { screen = 2; });
      configFile = {
        "plasmashellrc" = {
          # Monitor display numbers
          # Seems to be the same order as screen priorities in settings > display & monitor > display configuration
          # also seems to be the same as the ctrc value from the xrandr config
          "ScreenConnectors" = {
            "0" = "DisplayPort-1";
            "1" = "HDMI-A-0";
            "2" = "DisplayPort-0";
            "3" = "DisplayPort-2";
          };
        };
      };
    };
    autorandr = {
      enable = true;
      profiles = {
        nix-desktop-evo4b5 = {
          # nix-shell -p autorandr --run "autorandr --fingerprint"
          fingerprint = {
            DisplayPort-0 = "00ffffffffffff000472a501d207112001160104a52c197822ee91a3544c99260f5054bfee80714f81c08100a9c00101010101010101302a40c86084643018501300bbf91000001e000000fd00324c1e5010000a202020202020000000ff004c4e593038303033343232370a000000fc00416365722053323031484c0a2000f1";
            DisplayPort-1 = "00ffffffffffff001e6d735b1ff1030003200104a5351e789fa435a5544f9e27125054a54b80317c4568457c617c8168818081bc953c023a801871382d40582c4500132a2100001e5a8780a070384d4030203a00132a2100001a000000fd003090aaaa24010a202020202020000000fc004c4720554c545241474541520a019f020318f1230907074b010203041112131f903f40830100008048801871382d40582c4500132a2100001e866f80a07038404030203500132a2100001efe5b80a07038354030203500132a21000018011d007251d01e206e285500132a2100001e000000ff003230334e545653374c3333350a0000000000000000000000000094";
            DisplayPort-2 = "00ffffffffffff0006b3a12401010101341d010380351e78ea0ef5a555509e26105054bfef00714f818081409500a940b300d1cf0101023a801871382d40582c4500132b2100001e000000fd00284b1e5a19000a202020202020000000fc0056473234350a20202020202020000000ff004b434c4d51533038373739320a0103020327f14b900504030201111213141f230907078301000065030c001000681a00000101284be6023a801871382d40582c4500132b2100001e662156aa51001e30468f3300132b2100001e011d007251d01e206e285500132b2100001e8c0ad08a20e02d10103e9600132b2100001800000000000000000000000000000000b7";
            HDMI-A-0 = "00ffffffffffff0010ac79a055324e302c1a010380342078eaee95a3544c99260f5054a1080081408180a940b300d1c0010101010101283c80a070b023403020360006442100001a000000ff003456333544364150304e32550a000000fc0044454c4c2055323431324d0a20000000fd00323d1e5311000a202020202020012e02031b61230907078301000067030c002000802d43908402e2000f8c0ad08a20e02d10103e9600a05a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000029";
          };
          # a lot of these values can be grabbed from `xrandr --query --verbose`
          # or from `autorandr --save <config_name>` cd .config/autorandr/<config_name>/config
          config = {
            DisplayPort-1 = {
              enable = true;
              primary = true;
              crtc = 0;
              mode = "1920x1080";
              position = "3520x1080";
              rate = "143.98";
              dpi = null;
              filter = null;
              gamma = "1.0:1.0:1.0";
              rotate = null;
              scale = null;
              transform = null;
            };
            HDMI-A-0 = {
              enable = true;
              primary = false;
              crtc = 3;
              mode = "1920x1200";
              position = "0x1080";
              rate = "59.95";
              dpi = null;
              filter = null;
              gamma = "1.0:1.0:1.0";
              rotate = null;
              scale = null;
              transform = null;
            };
            DisplayPort-0 = {
              enable = true;
              primary = false;
              crtc = 1;
              mode = "1600x900";
              position = "1920x1080";
              rate = "60.00";
              dpi = null;
              filter = null;
              gamma = "1.0:1.0:1.0";
              rotate = null;
              scale = null;
              transform = null;
            };
            DisplayPort-2 = {
              enable = true;
              primary = false;
              crtc = 2;
              mode = "1920x1080";
              position = "1719x0";
              rate = "60.00";
              dpi = null;
              filter = null;
              gamma = "1.0:1.0:1.0";
              rotate = null;
              scale = null;
              transform = null;
            };
          };
        };
      };
    };
  };
}
