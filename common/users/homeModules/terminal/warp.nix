{ pkgs, ... }:
{
  imports = [
    ../unstable.nix
  ];
  home = {
    packages = with pkgs; [
      unstable.warp-terminal
    ];
  };
}
