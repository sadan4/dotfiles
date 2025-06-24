{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            android-studio-tools
            android-tools
            scrcpy
            android-studio
        ];
    };
}
