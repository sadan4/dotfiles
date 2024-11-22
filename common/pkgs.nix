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
    nixfmt-rfc-style
    nil
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
    (python312.withPackages (
      ps: with ps; [
        pytesseract
        pillow
        pyzbar
        pygobject3
        nanoid
        loguru
        evdev
        setuptools
        xlib
      ]
    ))
    nodejs_22
  ];
  gui = with pkgs; [
  screenkey
  pinned.vscode
    # (
    #   (pinned.vscode.override {
    #     isInsiders = true;
    #   }).overrideAttrs
    #   (
    #     _: old:
    #     let
    #       sourceExecutableName = "code-insiders";
    #       executableName = "code-insiders";
    #     in
    #     {
    #       installPhase = ''
    #         runHook preInstall
    #         mkdir -p "$out/lib/vscode" "$out/bin"
    #         cp -r ./* "$out/lib/vscode"
    #
    #         mv "$out/lib/vscode/bin/code" "$out/lib/vscode/bin/${sourceExecutableName}" # ME
    #
    #         ln -s "$out/lib/vscode/bin/${sourceExecutableName}" "$out/bin/${executableName}"
    #
    #         mkdir -p "$out/share/applications"
    #         ln -s "$desktopItem/share/applications/${executableName}.desktop" "$out/share/applications/${executableName}.desktop"
    #         ln -s "$urlHandlerDesktopItem/share/applications/${executableName}-url-handler.desktop" "$out/share/applications/${executableName}-url-handler.desktop"
    #
    #         # These are named vscode.png, vscode-insiders.png, etc to match the name in upstream *.deb packages.
    #         mkdir -p "$out/share/pixmaps"
    #         cp "$out/lib/vscode/resources/app/resources/linux/code.png" "$out/share/pixmaps/vs${executableName}.png"
    #
    #         # Override the previously determined VSCODE_PATH with the one we know to be correct
    #         sed -i "/ELECTRON=/iVSCODE_PATH='$out/lib/vscode'" "$out/bin/${executableName}"
    #         grep -q "VSCODE_PATH='$out/lib/vscode'" "$out/bin/${executableName}" # check if sed succeeded
    #
    #         # Remove native encryption code, as it derives the key from the executable path which does not work for us.
    #         # The credentials should be stored in a secure keychain already, so the benefit of this is questionable
    #         # in the first place.
    #         rm -rf $out/lib/vscode/resources/app/node_modules/vscode-encrypt
    #         # HOOK
    #         runHook postInstall
    #       '';
    #
    #       postFixup = ''
    #           patchelf \
    #         --add-needed ${pkgs.libglvnd}/lib/libGLESv2.so.2 \
    #         --add-needed ${pkgs.libglvnd}/lib/libGL.so.1 \
    #         --add-needed ${pkgs.libglvnd}/lib/libEGL.so.1 \
    #         $out/lib/vscode/code
    #       '';
    #     }
    #   )
    # )
    cpkg.frog
    legcord
    obsidian
    bottles
    parsec-bin
    jadx
    android-studio
    wireshark
    # pinned.vscode
    pinned.etcher
    insomnia
    teamviewer
    davinci-resolve
    warp-terminal
    gnome.gnome-calculator
    libsForQt5.kcolorchooser
    python312Packages.openai-whisper
    firefox-devedition
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
        jdk23
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
