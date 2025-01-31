{ pkgs, inputs, ... }:
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  home = {
    packages = with pkgs; [
      # spotify
      pulseaudioFull
      pavucontrol
    ];
  };
  stylix = {
    targets = {
      spicetify = {
        enable = false;
      };
    };
  };
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      alwaysEnableDevTools = true;
    };
  xdg = {
    desktopEntries = {
      spotifyOpen = {
        type = "Application";
        name = "Open in Spotify";
        genericName = "Music Player";
        icon = "spotify-client";
        terminal = false;
        categories = [
          "Audio"
          "Music"
          "Player"
          "AudioVideo"
        ];
        exec = "qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri %U";
        mimeType = [ "x-scheme-handler/spotify" ];
      };
    };
  };
}
