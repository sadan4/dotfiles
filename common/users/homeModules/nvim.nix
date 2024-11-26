{pkgs, lib, config, ...}: {
    home = {
        packages = with pkgs; [
            neovim
        ];
        file = {
            nvim = {
                recursive = true;
                source = lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
                target = "./.config/nvim";
            };
        };
        sessionVariables = {
            EDITOR = "nvim";
            MANPAGER = "nvim +Man!";
            MANWIDTH = "999";
        };
    };
}