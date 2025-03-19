{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      onefetch
      hyfetch
      neofetch
    ];
  };
}
