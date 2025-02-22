{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      # CLI ONLY
      unixtools.xxd
      p7zip
      dig
      bat
      usbutils
      tree
      sops
      fzf
      jq
      unzip
      unrar
    ];
    sessionVariables = {
      BAT_THEME = "Dracula";
      SSH_ASKPASS_REQUIRE = "prefer";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
