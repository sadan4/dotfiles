{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      gnupg
      openssh
      pinentry-curses
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
