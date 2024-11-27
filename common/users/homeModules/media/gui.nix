{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            shotcut
            pinta
            gimp
            inkscape
            obs-studio
        ];
    };
}
