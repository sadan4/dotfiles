{
  pkgs,
  config,
  inputs,
  cpkg,
}:
let
  pinned = import ./pinned.nix { inherit pkgs config; };
in
{
  dev = with pkgs; [
    meson
    deno
    rustup
    android-studio-tools
    vscode-langservers-extracted
    cmake
    nodePackages_latest.typescript-language-server
    lua
    go
    eslint_d
    typescript
    php
    clang
    gnumake
    gradle
    lazygit
    linuxHeaders
    eslint
    nodePackages.nodemon
    nodePackages.ts-node
    nodePackages.pnpm
    corepack_22
    prisma
    prisma-engines
    nodePackages.live-server
    gh
    glib
    glibc
    (python312.withPackages (ps: with ps;[
      pytesseract
      pillow
      pyzbar
      pygobject3
      nanoid
      loguru
      evdev
      setuptools
      xlib
    ]))
    nodejs_22
  ];
  gui = with pkgs; [
    cpkg.frog
    legcord
    obsidian
    bottles
    parsec-bin
    jadx
    android-studio
    wireshark
    pinned.vscode
    pinned.etcher
    insomnia
    teamviewer
    davinci-resolve
    warp-terminal
    gnome.gnome-calculator
    libsForQt5.kcolorchooser
    python312Packages.openai-whisper
    firefox-devedition
    cinny-desktop
    element-desktop
    protonvpn-gui
    xclicker
    polychromatic
    jellyfin-media-player
    arrpc
    filezilla
    virt-manager
    qemu_full
    shotcut
    pinta
    gimp
    inkscape
    #OCR ENGINE
    tesseract4
    (pkgs.discord.override {
      withVencord = true;
    })
    vesktop
    xsel
    spotify
    pulseaudioFull
    pavucontrol
    # jetbrains.pycharm-community
    jbeap.idea-ultimate
    google-chrome
    bitwarden
    nerdfonts
    # vscodium
    kitty
    rofi
    thunderbird
    vlc
    jellyfin-web
    obs-studio
    tokyo-night-gtk
    ksshaskpass
    libsForQt5.kinit
  ];
  general = with pkgs; [
    imagemagick
    onefetch
    p7zip
    dig
    bat
    usbutils
    tree
    ffmpeg
    yt-dlp
    neofetch
    sops
    hyfetch
    fzf
    zsh-powerlevel10k
    zsh-syntax-highlighting
    jq
    unzip
    btop
  ];
  gaming = with pkgs; [
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
        jdk22
      ];
    })
    protontricks
    lutris
  ];
  scripts = [
    (pkgs.writeShellScriptBin "hashi18n" ''
      xsel -ob | node ${cpkg.scripts}/hash.js | tr -d '\n' | xsel -ib
    '')
    (pkgs.writeShellScriptBin "paste" ''
      command -v xsel > /dev/null
      if [[ $? -eq 0 ]]; then
          xsel -ob && exit 0
      fi
      command -v wslclip > /dev/null
      if [[ $? -eq 0 ]]; then
          wslclip -g && exit 0
      fi
    '')
    (pkgs.writeShellScriptBin "http2ssh" ''
      set -eo pipefail

      if [[ -z $1 ]]; then
          echo "You need to provide a remote name";
          echo "Avilable remotes";
          git remote -v;
          exit 1;
      fi
      URL=''$(git remote get-url $1);
      URL=''${URL/https:\/\//git@};
      URL=''${URL/\//:};
      git remote set-url $1 $URL;
    '')
    (pkgs.writeShellScriptBin "copy" ''
      command -v xsel > /dev/null
      if [[ $? -eq 0 ]]; then
          xsel -ib $@ && exit 0
      fi
      command -v wslclip > /dev/null
      if [[ $? -eq 0 ]]; then
          wslclip $@ && exit 0
      fi

    '')
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
    (pkgs.writeShellScriptBin "math" ''
      set -e
      python3 -c "print($*)"
    '')
  ];
  wsl = with pkgs; [
    wslu
  ];
}
