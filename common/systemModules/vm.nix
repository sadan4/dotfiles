{ NAME }: { pkgs, ... }: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = with pkgs; [
            OVMF.fd
            pkgsCross.aarch64-multiplatform.OVMF.fd
          ];
        };
      };
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
