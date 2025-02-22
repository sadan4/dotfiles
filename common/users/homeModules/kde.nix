{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            filelight
            ksshaskpass
            xsel
            libsForQt5.kinit
            libsForQt5.kcolorchooser
            gnome-calculator
        ];
    };
}
