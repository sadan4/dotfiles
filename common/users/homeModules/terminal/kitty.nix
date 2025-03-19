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
    };
  };
  programs = {
    zsh = {
            # Completion support for kitten
      initExtra = ''
        compdef _kitty kitten
      '';
    };
  };
}
