{ inputs, ... }:
{
  nixpkgs = {
    overlays = [
      (pkgs: _: {
        cpkg = {
          # discord = pkgs.callPackage ./discord/default.nix { };
          # vesktop = pkgs.callPackage ./vesktop/default.nix { inherit vencord; };
          # vencord = pkgs.callPackage ./vencord/package.nix { };
          frog = pkgs.callPackage ./frog { };
          chrome-pak-customizer = pkgs.callPackage inputs.chrome-pak { };
          ceserver = inputs.ceserver.flakePackage pkgs;
          scripts = inputs.scripts.flakePackage pkgs;
        };
      })
    ];
  };
}
