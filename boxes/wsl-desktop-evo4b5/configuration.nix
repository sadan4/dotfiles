{ pkgs, ... }:
{
  imports = [
    ../../common/users/meyer-wsl
    ../../common/systemModules/nix.nix
  ];
  wsl = {
    defaultUser = "meyer";
    enable = true;
    wslConf = {
      network = {
        hostname = "wsl-desktop-evo4b5";
      };
    };
  };
  system.stateVersion = "24.05";
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    gcc
    clang
    ripgrep
    file
  ];
}
