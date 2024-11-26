{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            neovim
        ];
        file = {
            nvim = {
                recursive = true;
                source = pkgs.lib.file.mkOutOfStoreSymlink "${pkgs.home.homeDirectory}/nixos/dotfiles/nvim";
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