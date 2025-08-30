{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gnumake
      (binutils-unwrapped.override {
        withAllTargets = true;
      })
      # cloc but faster
      tokei
      libtree
      linuxHeaders
      man-pages
      d-spy
      hyperfine
    ];
    shellAliases = {
      cloc = "${pkgs.tokei}/bin/tokei";
    };
  };
}
