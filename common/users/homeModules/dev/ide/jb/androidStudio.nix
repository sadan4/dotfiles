{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            android-studio-tools
            android-studio
        ];
    };
}
