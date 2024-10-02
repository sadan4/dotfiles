{ lib, pkgs }:
let

  _ = [
    "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
    "source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh"
    "setopt globstarshort"
  ];
  zshInitArgs = lib.concatMapStrings (x: x + "\n") _;
in
{
  enable = true;
  oh-my-zsh.enable = true;
  initExtra = zshInitArgs;
}
