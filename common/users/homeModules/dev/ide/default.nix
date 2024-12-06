{pkgs, config, ...}:
let 
in {
    imports = [
        ../../pinned.nix
    ];
    home = {
        packages = with pkgs; [
            pinned.vscode
            # codium
            zed-editor
        ];
    };
}
