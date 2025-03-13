{ pkgs, stable, ... }:
{
  imports = [
    ./unstable.nix
  ];
  home = {
    packages = with pkgs; [
      pkgs.firefox-beta-bin
      vlc
      unstable.brave
    ];
  };
}
