{ pkgs, ... }:
{
  imports = [
    ./unstable.nix
  ];
  home = {
    packages = with pkgs; [
      firefox-beta
      vlc
      unstable.brave
    ];
  };
}
