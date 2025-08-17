{pkgs, ...}: {
    imports = [
        ./stable.nix
    ];
    home = {
        packages = with pkgs; [
            (bottles.override {
                removeWarningPopup = true;
            })
            virt-manager
            stable.qemu_full
        ];
    };
}
