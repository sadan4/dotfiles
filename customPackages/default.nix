{pkgs}:rec{
# discord = nixpkgs.callPackage ./discord { };
discord = pkgs.callPackage ./discord/default.nix {};
vesktop = pkgs.callPackage ./vesktop/default.nix {inherit vencord;};
vencord = pkgs.callPackage ./vencord/default.nix {};
}
