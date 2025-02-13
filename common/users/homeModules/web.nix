{ pkgs, ... }:
{
  imports = [
    ./unstable.nix
  ];
  home = {
    packages = with pkgs; [
      firefox-devedition
      google-chrome
      thunderbird
      jellyfin-web
      jellyfin-media-player
      vlc
      unstable.brave
    ];
  };
}
