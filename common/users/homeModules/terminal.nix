{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            warp-terminal
            kitty
            onefetch
            hyfetch
            neofetch
        ];
        file = {
            kitty = {
                recursive = true;
                source = ../../../dotfiles/kitty;
                target = "./.config/kitty";
            };
        };
    };
}
