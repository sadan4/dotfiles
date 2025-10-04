{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      # CLI ONLY
      unixtools.xxd
      btop
      pciutils
      tmux
      p7zip
      pciutils
      killall
      dig
      bat
      usbutils
      tree
      sops
      tlrc
      fzf
      jq
      unzip
      unrar
      # GUI version is in kde.nix
      libqalculate
      patchelf
    ];
    sessionVariables = {
      BAT_THEME = "Dracula";
      SSH_ASKPASS_REQUIRE = "prefer";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
  programs = {
    fzf = {
      enableZshIntegration = true;
    };
    zsh = {
      initContent = ''
        eval $(fzf --zsh)
      '';
    };
  };
  # FIXME: this errors
  # programs = {
  #   zsh = {
  #     # patchelf doesnt provide completions by default
  #     initContent = ''
  #       eval "$(cat ${
  #         pkgs.fetchurl {
  #           url = "https://raw.githubusercontent.com/NixOS/patchelf/b9976d63c2bb860a7616dd5b3093571b0b48d2a4/completions/zsh/_patchelf";
  #           hash = "sha256-fEnmZhC9sXSqHNz3JFJ30dj658+a6iBtqGq8q4mahyw=";
  #         }
  #       })";
  #     '';
  #   };
  # };
}
