{ pkgs, inputs }:
rec {
  # discord = nixpkgs.callPackage ./discord { };
  discord = pkgs.callPackage ./discord/default.nix { };
  vesktop = pkgs.callPackage ./vesktop/default.nix { inherit vencord; };
  vencord = pkgs.callPackage ./vencord/package.nix { };
  frog = pkgs.callPackage ./frog { };
  scripts = inputs.scripts.flakePackage pkgs;
}
