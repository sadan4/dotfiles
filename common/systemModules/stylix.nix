{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    base16scheme = ./tokyonight.yaml;
    fonts = {
      emoji = {
        package = pkgs.twemoji-color-font;
        name = "Twemoji Color Emoji";
      };
      sansSerif = {
        package = pkgs.nerdfonts;
        name = "ComicShannsMono Nerd Font Mono";
      };
      serif = {
        package = pkgs.nerdfonts;
        name = "ComicShannsMono Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "ComicShannsMono Nerd Font Mono";
      };
    };
  };
}
