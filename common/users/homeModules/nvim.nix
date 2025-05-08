{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      neovim
      nvimpager
    ];
    file = {
      nvim = {
        recursive = true;
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/nvim";
        target = "./.config/nvim";
      };
    };
    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      PAGER = "nvimpager";
    };
  };
}
