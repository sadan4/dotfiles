{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            ghidra
            ida-free
            cutter
        ];
    };
}
