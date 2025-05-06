{
  pkgs,
  config,
  ...
}:
let
  pager_cmd_var = ''nvim -R +\"nmap q <CMD>q\!<CR>\"'';
  pager_cmd_alias = ''nvim -R +"nmap q <CMD>q!<CR>"'';
in
{
  home = {
    packages = with pkgs; [
      neovim
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
      PAGER = pager_cmd_var;
    };
    shellAliases = {
      pager = pager_cmd_alias;
    };
  };
}
