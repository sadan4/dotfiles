{ pkgs, config }: {
  polychromatic = {
    Unit = {
      Description = "razer chroma applet/daemon";
    };
    Install = {
        WantedBy = [ "default.target" ];
    };
    Service = {
        ExecStart = "${pkgs.polychromatic}/bin/polychromatic-tray-applet";
    };
  };
}
