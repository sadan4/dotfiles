{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./pinned.nix
  ];
  home = {
    packages = with pkgs; [
      pinned.neovim
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
