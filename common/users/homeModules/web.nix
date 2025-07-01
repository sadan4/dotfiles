{ pkgs, stable, ... }:
{
  imports = [
    ./unstable.nix
  ];
  home = {
    packages = with pkgs; [
      firefox
      vlc
      unstable.brave
    ];
  };
}
