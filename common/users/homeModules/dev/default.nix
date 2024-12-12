{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            gnumake
            binutils
            linuxHeaders
            man-pages
        ];
    };
}
