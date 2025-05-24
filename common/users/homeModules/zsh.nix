{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      powershell
      zsh-powerlevel10k
      zsh-syntax-highlighting
      asciinema
      asciinema-agg
    ];
    sessionVariables = {
      POWERSHELL_PATH = "${pkgs.powershell}/bin/pwsh";
    };
    file = {
      p10k = {
        recursive = true;
        source = ../../../dotfiles/.p10k.zsh;
        target = ".p10k.zsh";
      };
    };
  };
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        setopt globstarshort
        eval "$(${pkgs.docker}/bin/docker completion zsh)"
        # *c*d into *n*ew *d*irectory
        cnd() {
            mkdir $1 && cd $1;
        }
        # MUST COME AFTER p10k
        # make  clear the scrollback buffer as well as the screen
        # copy clear-screen into _orig_clear_Screen
        zle -A clear-screen _orig_clear_screen
        # define zsh widget func
        _CLEAR() {
            # clears the scrollback buffer
            printf '\033[3J'
            # call the orig clear-screen to do some housekeeping
            zle _orig_clear_screen
        }
        # define our new widget
        zle -N _CLEAR _CLEAR
        # bind it to 
        bindkey  _CLEAR
      '';
      enableCompletion = true;
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];
    };
  };
}
