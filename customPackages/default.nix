{ inputs, pkgs, ... }:
let
  system = pkgs.system;
in
{
  nixpkgs = {
    overlays = [
      (pkgs: _: {
        cpkg = {
          # discord = pkgs.callPackage ./discord/default.nix { };
          # vesktop = pkgs.callPackage ./vesktop/default.nix { inherit vencord; };
          # vencord = pkgs.callPackage ./vencord/package.nix { };
          frog = pkgs.callPackage ./frog { };
          appimagetool = pkgs.callPackage ./appimagetool { };
          chrome-pak-customizer = inputs.chrome-pak.flakePackage pkgs;
          ceserver = inputs.ceserver.flakePackage pkgs;
          scripts = (pkgs.callPackage ./scripts) { useLocal = true; };
        };
      })
    ];
  };
}
