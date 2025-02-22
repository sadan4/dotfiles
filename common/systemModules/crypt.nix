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
    };
    gnupg = {
      agent = {
        enable = true;
      };
    };
  };
}
