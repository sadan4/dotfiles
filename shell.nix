 { pkgs ? import <nixpkgs> {} }: 
 pkgs.mkShell {
    nativeBuildInputs = with pkgs;[
    bash
        sops
        ssh-to-age
        git
        openssh
        neovim
        nano
        wget
        curl
    ];
 }
