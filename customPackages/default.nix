{ pkgs }:
let
    src_frog = ( pkgs.fetchFromGitHub {
        owner = "sadan4";
        repo = "frog";
        rev = "2f2cc11ce7866e9b4bd0f6c52ba0cef25e95a468";
        hash = "sha256-KkoNi8Rx0Q6MIzgzvpCJhGI82tDWuflBQO2dFS0h8ig=";
    });
in
rec{
  # discord = nixpkgs.callPackage ./discord { };
  discord = pkgs.callPackage ./discord/default.nix { };
  vesktop = pkgs.callPackage ./vesktop/default.nix { inherit vencord; };
  vencord = pkgs.callPackage ./vencord/package.nix { };
    frog = pkgs.callPackage (import src_frog)  {};
}
