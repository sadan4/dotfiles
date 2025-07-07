{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gnumake
      (binutils-unwrapped.override {
        withAllTargets = true;
      })
      cloc
      libtree
      linuxHeaders
      man-pages
      d-spy
    ];
  };
}
