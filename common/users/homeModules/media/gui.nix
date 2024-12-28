{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            shotcut
            pinta
            krita
            gimp
            inkscape
            obs-studio
        ];
    };
}
