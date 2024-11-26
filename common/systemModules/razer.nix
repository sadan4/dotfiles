{ NAME }: { ... }: {

  environment.systemPackages = with pkgs; [
    polychromatic
  ];
  hardware = {
    openrazer = {
      enable = true;
      users = [ NAME ];
    };
  };
}
