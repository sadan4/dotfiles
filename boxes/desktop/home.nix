{ config, pkgs, inputs,... }:

{

 nixpkgs.config.allowUnfreePredicate = (pkg: true);
  # Home Manager needs a bit of information about you and the paths it should
  # nixpkg.config.allowUnfree = true;
  # manage.
  home.username = "meyer";
  home.homeDirectory = "/home/meyer";

  programs = {
    
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    hello
    xsel
    google-chrome
    bitwarden
    spotify
    steam
    vscodium
    vesktop
    kitty
    # pkgs.rofi
    go
    php
    nodejs_21
    # pkgs.temurin-jre-bin-8
    cargo
    lua
    btop
    unzip
    temurin-bin-8
    protonvpn-gui
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  kitty = {
    #recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/kitty;
    target = "./.config/kitty";
  };
  btop = {
    #recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/btop;
    target = "./.config/btop";
  };
  # "testconfigfile".source = ../../dotfiles/testconfigfile;
    # ".gitconfig".source = ../../dotfiles/.gitconfig;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/meyer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
     MANPAGER = "nvim +Man!";
     MANWIDTH = "999";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
