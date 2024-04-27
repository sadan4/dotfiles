{pkgs}:{
# discord = nixpkgs.callPackage ./discord { };
discord = pkgs.callPackage ./discord/default.nix {};
vesktop = pkgs.callPackage ./vesktop/default.nix {};
}
