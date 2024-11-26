{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            btop
        ];
        file = {
            btop = {
                recursive = true;
                source = ../../../dotfiles/btop;
                target = "./.config/btop";
            };
        };
    };
}