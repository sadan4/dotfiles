{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            meson
            cmake
            clang
            glib
            glibc
            llvmPackages_19.clang-tools
        ];
        file = {
            eslint_d_config = {
                source = ../../../../dotfiles/eslintrc.json;
                target = "./.config/.eslintrc.json";
            };
        };
    };
}