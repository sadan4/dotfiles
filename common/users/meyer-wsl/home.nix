{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowInsecurePredicate = (pkg: true);
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  imports = [
    ../homeModules/utils.nix
    ../homeModules/dev
    ../homeModules/dev/cpp.nix
    ../homeModules/dev/javascript.nix
    ../homeModules/dev/python.nix
    ../homeModules/scripts
    ../homeModules/btop.nix
    ../homeModules/git.nix
    ../homeModules/nvim.nix
    ../homeModules/sops.nix
    ../homeModules/zsh.nix
  ];

  home.username = "meyer";
  home.homeDirectory = "/home/meyer";

  home = {
    packages = with pkgs; [
      wslu
    ];
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}