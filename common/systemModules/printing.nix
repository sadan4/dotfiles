{ pkgs, ... }: {
  services = {
    avahi = {
      enable = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
  };
}
