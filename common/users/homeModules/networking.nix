{pkgs, stable, ...}: {
    home = {
        packages = with pkgs; [
            parsec-bin
            stable.protonvpn-gui
            insomnia
            teamviewer
            filezilla
            bitwarden
        ];
    };
}
