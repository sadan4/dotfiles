{ lib, pkgs, ... }:
let

  _ = [
    "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    "source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "eval \"$(${pkgs.nh}/bin/nh completions --shell=zsh)\""
    "eval \"$(${pkgs.nodejs_22}/bin/node --completion-bash)\""
    "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
    "setopt globstarshort"
  ];
  zshInitArgs = lib.concatMapStrings (x: x + "\n") _;
in
{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      initExtra = zshInitArgs;
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
