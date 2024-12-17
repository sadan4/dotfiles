{ pkgs, inputs, ... }:
{
  imports = [
    ../../../customPackages
  ];
  home = {
    packages = with pkgs.cpkg;[
      frog
    ];
  };
}
