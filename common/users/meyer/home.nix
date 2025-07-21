{
  ...
}:
{
  nixpkgs.config.allowInsecurePredicate = (pkg: true);
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  imports = [
    ../homeModules/utils.nix
    ../homeModules/dev
    ../homeModules/dev/ide
    ../homeModules/dev/ide/reverseEng.nix
    ../homeModules/dev/ide/jb/idea.nix
    ../homeModules/dev/javascript.nix
    ../homeModules/dev/nix.nix
    ../homeModules/dev/cpp.nix
    ../homeModules/dev/go.nix
    ../homeModules/dev/jvm.nix
    ../homeModules/dev/python.nix
    ../homeModules/dev/vim.nix
    ../homeModules/dev/rust.nix
    ../homeModules/media
    ../homeModules/scripts
    ../homeModules/audio.nix
    ../homeModules/etcher.nix
    ../homeModules/flameshot.nix
    ../homeModules/frog.nix
    ../homeModules/gaming.nix
    ../homeModules/git
    ../homeModules/kde.nix
    ../homeModules/networking.nix
    ../homeModules/nvim.nix
    ../homeModules/obsidian.nix
    ../homeModules/rofi.nix
    ../homeModules/social.nix
    ../homeModules/sops.nix
    ../homeModules/terminal
    ../homeModules/virt.nix
    ../homeModules/web.nix
    ../homeModules/zsh.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # nixpkg.config.allowUnfree = true;
  # manage.
  home.username = "meyer";
  home.homeDirectory = "/home/meyer";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.shellAliases = {
    sd = ''lsusb | grep Elgato | grep --perl-regexp "(?<=Device 0{0,10})[1-9]+" --only-matching | xargs printf "usb.device_address eq %s" | copy'';
  };
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
