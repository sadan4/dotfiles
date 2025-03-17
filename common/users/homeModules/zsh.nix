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
        eval "$(${pkgs.nh}/bin/nh completions --shell=zsh)"
        setopt globstarshort
        eval "$(${pkgs.docker}/bin/docker completion zsh)"
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
