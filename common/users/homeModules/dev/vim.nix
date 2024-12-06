{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            vim-language-server
        ];
    };
}
