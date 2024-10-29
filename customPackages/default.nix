{ pkgs }:
let
in
rec{
  # discord = nixpkgs.callPackage ./discord { };
  discord = pkgs.callPackage ./discord/default.nix { };
  vesktop = pkgs.callPackage ./vesktop/default.nix { inherit vencord; };
  vencord = pkgs.callPackage ./vencord/package.nix { };
    frog = pkgs.callPackage ./frog {};
}
