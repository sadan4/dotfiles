{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            ksshaskpass
            xsel
            libsForQt5.kinit
            libsForQt5.kcolorchooser
            gnome.gnome-calculator
        ];
    }
}