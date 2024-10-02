{ NAME }: { ... }: {
  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };
  users = {
    users = {
      "${NAME}" = {
        extraGroups = [ "kvm" "libvirtd" ];
      };
    };
  };
}
