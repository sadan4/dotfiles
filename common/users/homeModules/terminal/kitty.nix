{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      kitty
    ];
    file = {
      kitty = {
        recursive = true;
        source = ../../../../dotfiles/kitty;
        target = "./.config/kitty";
      };
    };
    shellAliases = {
      "icat" = "kitten icat";
      # **N**ew **K**itty
      "nk" = "kitty --detach";
    };
  };
  programs = {
    zsh = {
      # Completion support for kitten
      initExtra = ''
        compdef _kitty kitten
      '';
    };
    plasma = {
      hotkeys = {
        commands = {
          "kitty" = {
            name = "kitty";
            key = "Alt+Shift+Return";
            command = "kitty";
          };
        };
      };
    };
  };
}
