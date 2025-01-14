{ config, ... }: {
  systemd.user.services.flameshot.Unit.After = [];
  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "/home/${config.home.username}/ss/";
          saveAsFileExtension = ".png";
          showDesktopNotification = false;
        };
      };
    };
  };
}
