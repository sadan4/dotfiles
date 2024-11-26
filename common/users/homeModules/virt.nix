{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            bottles
            virt-manager
            qemu_full
        ];
    };
}