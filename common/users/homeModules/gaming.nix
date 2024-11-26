{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            xclicker
            bottles
            (prismlauncher.override {
                jdks = [
                    jdk8
                    jdk17
                    jdk22
                ];
            })
            protontricks
            lutris
        ];
    };
}