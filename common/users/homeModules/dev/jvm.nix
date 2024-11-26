{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      android-studio-tools
      gradle
      jadx
      android-studio
      jetbrains.idea-ultimate
      # jbeap.idea-ultimate
    # jetbrains.pycharm-community
    ];
  };
  programs = {
    java = {
      enable = true;
      package = pkgs.temurin-bin-17;
    };
  };
}
