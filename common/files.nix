{ config }: rec{
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
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/gh";
      target = "./.config/gh";
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