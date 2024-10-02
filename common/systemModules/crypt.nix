{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      gnupg
      openssh
      pinentry-curses
      pinentry
    ];
  };
  programs = {
    ssh = {
      startAgent = true;
      askPassword = "${pkgs.ksshaskpass}/bin/ksshaskpass";
    };
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-gnome3;
      };
    };
  };
}
