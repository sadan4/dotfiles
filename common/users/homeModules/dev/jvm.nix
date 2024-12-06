{ pkgs, ... }: {
  imports = [
    ./ide/jb/idea.nix
    ./ide/jb/androidStudio.nix
  ];
  home = {
    packages = with pkgs; [
      gradle
      jadx
    ];
  };
  programs = {
    java = {
      enable = true;
      package = pkgs.temurin-bin-17;
    };
  };
}
