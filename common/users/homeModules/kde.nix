{pkgs, ...}: {
    imports = [
        ./plasma.nix
    ];
    home = {
        packages = with pkgs; [
            kdePackages.filelight
            kdePackages.ksshaskpass
            xsel
            kdePackages.kcolorchooser
            qalculate-qt
            gnome-disk-utility
        ];
    };
}
