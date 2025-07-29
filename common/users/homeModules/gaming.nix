{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            xclicker
            (bottles.override {
                removeWarningPopup = true;
            })
            (prismlauncher.override {
                jdks = [
                    jdk8
                    jdk17
                    jdk23
                    jdk
                ];
            })
            # needed for prism launcher dialogs
            zenity
            protontricks
            lutris
        ];
    };
}
