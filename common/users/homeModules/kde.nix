{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            kdePackages.filelight
            kdePackages.ksshaskpass
            xsel
            kdePackages.kcolorchooser
            gnome-calculator
        ];
    };
}
