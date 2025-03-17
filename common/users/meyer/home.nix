{
util,
  ...
}:
{
  nixpkgs.config.allowInsecurePredicate = (pkg: true);
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  imports = util.modulesFromPath ../homeModules [
    ./utils.nix
    ./dev
    ./dev/ide
    ./dev/ide/reverseEng.nix
    ./dev/ide/jb/idea.nix
    ./dev/javascript.nix
    ./dev/nix.nix
    ./dev/cpp.nix
    ./dev/go.nix
    ./dev/jvm.nix
    ./dev/python.nix
    ./dev/vim.nix
    ./dev/rust.nix
    ./media
    ./scripts
    ./audio.nix
    ./btop.nix
    ./etcher.nix
    ./flameshot.nix
    ./frog.nix
    ./gaming.nix
    ./git.nix
    ./kde.nix
    ./networking.nix
    ./nvim.nix
    ./obsidian.nix
    ./rofi.nix
    ./social.nix
    ./sops.nix
    ./terminal.nix
    ./virt.nix
    ./web.nix
    ./zsh.nix
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
