{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      gnumake
      (binutils-unwrapped.override {
        withAllTargets = true;
      })
      libtree
      linuxHeaders
      man-pages
      d-spy
    ];
  };
}
