{ pkgs, ... }:
{
  imports = [
    ./overlays.nix
  ];
  home.packages = with pkgs; [
    vscode-insider
  ];
}
