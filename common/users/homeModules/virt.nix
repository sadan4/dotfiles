{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            (bottles.override {
                removeWarningPopup = true;
            })
            virt-manager
            qemu_full
        ];
    };
}
