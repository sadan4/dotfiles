{pkgs}:{
# discord = nixpkgs.callPackage ./discord { };
discord = pkgs.callPackage ./discord/default.nix {};
}
