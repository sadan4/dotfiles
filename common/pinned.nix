# https://lazamar.co.uk/nix-versions/
{}:
let 
    # 1.89.1
    vsc_pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb.tar.gz";
    }) {};
in {
    vscode = vsc_pkgs.vscode;
}
