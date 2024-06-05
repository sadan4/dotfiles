{ config, lib, pkgs, inputs, ... }:

let
    flameshot = import ../../common/programs/flameshot.nix {inherit config;};
  _s1 = import ../../common/sops.nix { inherit config; };
  files = import ../../common/files.nix { inherit config; };
  shell = import ../../common/shell.nix { inherit config pkgs; };
  p = import ../../common/pkgs.nix { inherit pkgs config; };
  _p1 = p.dev ++ p.gui ++ p.general ++ p.scripts ++ p.gaming;
  zshInitArgs = [
    "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    "source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
    "setopt globstarshort"
  ];
  _z1 = lib.concatMapStrings (x: x + "\n") zshInitArgs;

in
{
nixpkgs.config.allowInsecurePredicate = (pkg: true);
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  sops = _s1;
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.initExtra = builtins.trace _z1 _z1;
  programs.java.enable = true;
  programs.java.package = pkgs.temurin-bin-17;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.git.enable = true;
  programs.git.userName = "sadan";
  programs.git.userEmail = "117494111+sadan4@users.noreply.github.com";
  programs.git.extraConfig = {
    gpg.format = "ssh";
    user = {
      signingkey = "~/.ssh/id_ed25519";
    };
    commit.gpgsign = true;
    core.autocrlf = "input";
    pull.rebase = true;
    push.autoSetupRemote = true;
    init.defaultBranch = "main";
    rerere.enabled = true;
  };

  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  # Home Manager needs a bit of information about you and the paths it should
  # nixpkg.config.allowUnfree = true;
  # manage.
  home.username = "meyer";
  home.homeDirectory = "/home/meyer";


  services = {
    inherit flameshot;
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = _p1;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = files;

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
  home.shellAliases = shell.dev.aliases;
  home.sessionPath = shell.dev.path;
  home.sessionVariables = shell.dev.env;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
