{pkgs, lib, config, ...}: {
    home = {
        packages = with pkgs; [
            neovim
        ];
        file = {
            nvim = {
                recursive = true;
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
                target = "./.config/nvim";
            };
        };
        sessionVariables = {
            EDITOR = "nvim";
            MANPAGER = "nvim +Man!";
            # readonly, quit on q
            PAGER = "nvim -R +\"nmap q <CMD>q!<CR>\"";
        };
    };
}
