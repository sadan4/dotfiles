{ pkgs, config }:
let
  cpkg = import ../customPackages { inherit pkgs; };
in
{
  dev = with pkgs;[
    nodePackages_latest.typescript-language-server
    cargo
    lua
    go
    protonvpn-gui
    eslint_d
    typescript
    php
    clang
    gnumake
    gradle
    lazygit
    linuxHeaders
    nodePackages.nodemon
    nodePackages.ts-node
    nodePackages.pnpm
    corepack_22
    nodePackages.prisma
    prisma-engines
    nodePackages.live-server
    gh
    glib
    glibc
    (python39.withPackages (ps: with ps;[
      evdev
      setuptools
      xlib
    ]))
    nodejs_22
  ];
  gui = with pkgs;[
    virt-manager
    qemu_full
    shotcut
    pinta
    gimp
    inkscape
    #OCR ENGINE
    tesseract4
    cpkg.discord
    xsel
    spotify
    pulseaudioFull
    pavucontrol
    jetbrains.pycharm-community
    jetbrains.idea-community-bin
    google-chrome
    bitwarden
    nerdfonts
    vscodium
    kitty
    rofi
    cpkg.vesktop
    thunderbird
    vlc
    jellyfin-web
    obs-studio
    tokyo-night-gtk
    ksshaskpass
    libsForQt5.kinit
  ];
  general = with pkgs; [
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
        jdk19
      ];
    })
    protontricks
    lutris
  ];
  scripts = [
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
    (pkgs.writeShellScriptBin "ocr" ''
      set -euo pipefail
      TEMP=$(mktemp)
      flameshot gui -s -r > $TEMP
      (tesseract $TEMP --oem 1 -l eng | copy )|| copy "OCR RETUNRED NON-ZERO"
    '')
  ];
  wsl = with pkgs;[
    wslu
  ];
}
