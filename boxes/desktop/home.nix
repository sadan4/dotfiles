{ config, lib, pkgs, inputs, ... }:

let
  cpkg = import ../../customPackages { inherit pkgs; };
  zshInitArgs = [
    "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    "source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
    "setopt globstarshort"
  ];
  _z1 = lib.concatMapStrings (x: x + "\n") zshInitArgs;
in
{
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.initExtra = builtins.trace _z1 _z1;
  programs.java.enable = true;
  programs.java.package = pkgs.temurin-bin-17;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;


  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  # Home Manager needs a bit of information about you and the paths it should
  # nixpkg.config.allowUnfree = true;
  # manage.
  home.username = "meyer";
  home.homeDirectory = "/home/meyer";


  services = {
    flameshot = {
      enable = true;
      settings.General.showDesktopNotification = false;
      settings.General.startupLaunch = false;
      # settings.Shortcuts.TYPE_IMAGEUPLOADER = "";
      # settings.Shortcuts.TYPE_COPY = "Return";
    };
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
    jetbrains.pycharm-community
    jetbrains.idea-community-bin
    tailscale
    clang
    gnumake
    jq
    gradle
    lazygit
    protontricks
    thunderbird
    vlc
    jellyfin-web
    obs-studio
    tokyo-night-gtk
    linuxHeaders
    #NODE
    nodePackages.nodemon
    nodePackages.ts-node
    nodePackages.pnpm
    nodePackages.prisma
    prisma-engines
    nodePackages.live-server
    #ENDNODE
    zsh-powerlevel10k
    zsh-syntax-highlighting

    hello
    gh
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk19
      ];
    })
    ksshaskpass
    libsForQt5.kinit
    fzf
    #C AND CXX START
    glib
    glibc
    #C AND CXX END

    #PYTHONSTART
    (python39.withPackages (ps: with ps;[
      evdev
      xlib
    ]))
    # python311Packages.evdev
    # python311Packages.xlib
    #PYTHONEND
    #JAVASTART
    pkgs.discord

    #JAVAEND
    xsel
    google-chrome
    bitwarden
    eslint_d
    spotify
    vscodium
    pulseaudioFull
    cpkg.vesktop
    kitty
    rofi
    go
    php
    nodejs_21
    # pkgs.temurin-jre-bin-8
    cargo
    nerdfonts
    lua
    btop
    unzip
    protonvpn-gui
    typescript
    #MASON
    nodePackages_latest.typescript-language-server
    #ENDMASON
    # # You can also create simple shell scripts directly inside your

    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (pkgs.writeShellScriptBin "git_fetchAll" ''
          git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "''${remote#origin/}" "$remote"; done
      git fetch --all
      git pull --all
    '')
    (pkgs.writeShellScriptBin "install_eslint" ''
      set -x
      cp /home/${config.home.username}/.config/.eslintrc.json .
      pkgs=("@stylistic/eslint-plugin" "@typescript-eslint/eslint-plugin")
      if [[ -z $1 ]]; then
          echo please specify npm, pnpm, or yarn
          exit 1
      fi
      for i in "''${pkgs[@]}"; do
        `$1 i -D $i`
      done
    '')
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    kitty = {
      recursive = true;
      source = ../../dotfiles/kitty;
      target = "./.config/kitty";
    };
    eslint_d_config = {
      source = ../../dotfiles/eslintrc.json;
      target = "./.config/.eslintrc.json";
    };
    gh = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/gh";
      target = "./.config/gh";
    };
    btop = {
      recursive = true;
      source = ../../dotfiles/btop;
      target = "./.config/btop";
    };
    nvim = {
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
      target = "./.config/nvim";
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
  home.shellAliases = {
    paste = "xsel -ob";
    lg = "lazygit";
    copy = "xsel -ib";
    b = "/home/${config.home.username}/nixos/build";
  };
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
    MANWIDTH = "999";
    SSH_ASKPASS_REQUIRE = "prefer";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
