{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            parsec-bin
            protonvpn-gui
            insomnia
            teamviewer
            filezilla
            bitwarden
        ];
    };
}