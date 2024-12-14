{ pkgs, config, ... }: {
  home = {
    packages = with pkgs; [
      git
      lazygit
      act
      gh
    ];
    file = {
      lazygit = {
        recursive = true;
        source = ../../../dotfiles/lazygit;
        target = "./.config/lazygit";
      };
      gh = {
        source = ../../../dotfiles/gh/config.yml;
        target = "./.config/gh/config.yml";
      };
    };
    shellAliases = {
      lg = "lazygit";
    };
    sessionVariables = {
      LG_CONFIG_FILE = "/home/${config.home.username}/.config/lazygit/tokyonight_night.conf";
    };
  };
  programs = {
    git = {
      enable = true;
      userName = "sadan";
      userEmail = "117494111+sadan4@users.noreply.github.com";
      lfs = {
        enable = true;
      };
      extraConfig = {
        gpg = {
          format = "ssh";
        };
        user = {
          signingkey = "~/.ssh/id_ed25519";
        };
        commit = {
          gpgsign = true;
        };
        core = {
          autocrlf = "input";
        };
        pull = {
          rebase = true;
        };
        push = {
          autoSetupRemote = true;
        };
        init = {
          defaultBranch = "main";
        };
        rerere = {
          enabled = true;
        };
      };
    };
  };
}
