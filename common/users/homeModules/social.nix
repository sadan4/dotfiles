{ pkgs, inputs, config, ... }:
{
  imports = [
    ./arrpc.nix
    inputs.nixcord.homeManagerModules.nixcord
  ];
  programs.nixcord = {
    enable = false;
    discord = {
      enable = true;
      vencord = {
        enable = true;
        unstable = true;
      };
    };
  };
  home = {
    packages = with pkgs; [
      legcord
      cinny-desktop
      element-desktop
      vesktop
      (config.programs.nixcord.discord.package.override {
        withVencord = true;
        vencord = config.programs.nixcord.discord.vencord.package;
      })
    ];
  };
}
