 { pkgs ? import <nixpkgs> {} }: 
 pkgs.mkShell {
    nativeBuildInputs = with pkgs;[
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
