{ ... }:
{
  xdg = {
    desktopEntries = {
      spotifyOpen = {
        type = "Application";
        name = "Open in Spotify";
        genericName = "Music Player";
        icon = "spotify-client";
        terminal = false;
        categories = [ "Audio" "Music" "Player" "AudioVideo" ];
        exec = "qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri %U";
        mimeType = [ "x-scheme-handler/spotify" ];
      };
    };
  };
}
