{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            gnumake
            linuxHeaders
        ];
    };
}