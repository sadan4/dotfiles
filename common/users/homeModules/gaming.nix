{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            xclicker
            bottles
            (prismlauncher.override {
                jdks = [
                    jdk8
                    jdk17
                    jdk23
                ];
            })
            # needed for prism launcher dialogs
            zenity
            protontricks
            lutris
        ];
    };
}
