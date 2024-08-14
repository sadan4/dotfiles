{ pkgs, config }:
let
  cpkg = import ../customPackages { inherit pkgs; };
in
{
  dev = with pkgs;[
    vscode-langservers-extracted
    cmake
    nodePackages_latest.typescript-language-server
    cargo
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
    nodePackages.eslint
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
  overlays = {
    discord = (final: prev: {
      discord = prev.discord.override {
        # withOpenASAR = false;
        # withVencord = true;
        # pname = "Discord";
        vencord = cpkg.vencord;
      };
    });
  };
  gui = with pkgs;[
    python312Packages.openai-whisper
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
    # discord = cpkg.discord.override {
    #     withOpenASAR = true;
    #     withVencord = true;
    # };
    # (self: super: {
    #   discord = super.discord (oldAttrs: {
    #     # mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #     withVencord = true;
    #     vencord = cpkg.vencord;
    #   });
    # })
    # (pkgs.discord.override {
    #   vencord = cpkg.vencord;
    # })
    # (pkgs.vesktop.override {
    #   vencord = cpkg.vencord;
    # })
    xsel
    spotify
    pulseaudioFull
    pavucontrol
    # jetbrains.pycharm-community
    jetbrains.idea-community-bin
    google-chrome
    bitwarden
    nerdfonts
    vscodium
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
    ''
    )
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
