{pkgs, config, ...}:
let 
    pinned = import ../pinned.nix { inherit pkgs config; };
in {
    home = {
        packages = with pkgs; [
            pinned.vscode
            # codium
            zed-editor
        ];
    };
}