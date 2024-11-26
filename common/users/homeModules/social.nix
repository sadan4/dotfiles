{pkgs, ...}: {
    imports = [
        ./arrpc.nix
    ];
    home = {
        packages = with pkgs;[
            legcord
            cinny-desktop
            element-desktop
            (pkgs.discord.override {
                withVencord = true;
            })
            vesktop
        ];
    };
}