{ pkgs, ... }:
let
  g = (pkgs.gradle.override {
    javaToolchains = [ pkgs.graalvm-ce ];
  });
in
{
  imports = [
    ./ide/jb/idea.nix
    ./ide/jb/androidStudio.nix
  ];
  home = {
    sessionVariables = {
      GRAALVM_HOME = "${pkgs.graalvm-ce}";
    };
    file = {
      gradleIntellij = {
        source = "${pkgs.graalvm-ce}";
        target = ".local/graalvm";
      };
    };
    packages = with pkgs; [
      jadx
      g
      kotlin
    ];
  };
  programs = {
    java = {
      enable = true;
      package = pkgs.temurin-bin-23;
    };
  };
}
