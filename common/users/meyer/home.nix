{ config, pkgs, ... }:

let
  file = import ../../files.nix { inherit config; };
  shell = import ../../shell.nix { inherit config pkgs; };
  pkgTypes = import ../../pkgs.nix { inherit pkgs config; };
  packages = pkgTypes.dev ++ pkgTypes.gui ++ pkgTypes.general ++ pkgTypes.scripts ++ pkgTypes.gaming;
in
{
  nixpkgs.config.allowInsecurePredicate = (pkg: true);
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  imports = [
    ../homeModules/flameshot.nix
    ../homeModules/arrpc.nix
    ../homeModules/zsh.nix
    ../homeModules/desktopEntries.nix
    ../homeModules/java.nix
    ./sops.nix
    ./git.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # nixpkg.config.allowUnfree = true;
  # manage.
  home.username = "meyer";
  home.homeDirectory = "/home/meyer";


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home = {
    inherit packages file;
  };
  home.shellAliases = shell.dev.aliases;
  home.sessionPath = shell.dev.path;
  home.sessionVariables = shell.dev.env;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/meyer/etc/profile.d/hm-session-vars.sh
  #

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
