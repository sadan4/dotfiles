{pkgs, ...}: {
    home = {
        packages = with pkgs; [
            imagemagick
            ffmpeg
            yt-dlp
        ];
    }
}