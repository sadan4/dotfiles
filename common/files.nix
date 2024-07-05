{ config }: rec{
  lazygit = {
    recursive = true;
    source = ../dotfiles/lazygit;
    target = "./.config/lazygit";
  };
  kitty = {
    recursive = true;
    source = ../dotfiles/kitty;
    target = "./.config/kitty";
  };
  eslint_d_config = {
    source = ../dotfiles/eslintrc.json;
    target = "./.config/.eslintrc.json";
  };
  gh = {
    source = ../dotfiles/gh/config.yml;
    target = "./.config/gh/config.yml";
  };
  btop = {
    recursive = true;
    source = ../dotfiles/btop;
    target = "./.config/btop";
  };
  nvim = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
    target = "./.config/nvim";
  };
  p10k = {
    recursive = true;
    source = ../dotfiles/.p10k.zsh;
    target = ".p10k.zsh";
  };
  rofi = {
    recursive = true;
    source = ../dotfiles/rofi;
    target = "./.config/rofi";
  };
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
}
