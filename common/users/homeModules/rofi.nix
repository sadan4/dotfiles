{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            rofi
        ];
        file = {
            rofi = {
                recursive = true;
                source = ../dotfiles/rofi;
                target = "./.config/rofi";
            };
        };
    };
}