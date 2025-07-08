{ pkgs, ... }:
{
  imports = [
    ../../../pinned.nix
  ];
  home = {
    packages =
      let
        ij = pkgs.pinned.idea-ultimate;
      in
      with pkgs;
      [
        # (buildFHSEnv {
        #   name = "idea-ultimate";
        #   inherit (ij) version meta;
        #   targetPkgs = _: [
        #     ij
        #     libz
        #     libGL
        #     freetype
        #     fontconfig
        #     xorg.libXi
        #     xorg.libX11
        #     xorg.libXtst
        #     xorg.libXrender
        #     xorg.libXext
        #     libappindicator
        #     gtk3
        #   ];
        #   runScript = lib.getExe ij;
        #   extraInstallCommands = ''
        #     mkdir -p $out/share/applications
        #     cp ${ij}/share/applications/idea-ultimate.desktop $out/share/applications/idea-ultimate.desktop
        #   '';
        # })
        ij
      ];
  };
}
