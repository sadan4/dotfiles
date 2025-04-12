{ pkgs, config, ... }:
let
in
{
  imports = [
    ../../pinned.nix
    ../../unstable.nix
  ];
  home = {
    packages = with pkgs; [
      unstable.vscode
      # pinned.vscode
      # (pinned.vscode.fhsWithPackages (
      #   pkgs: with pkgs; [
      #     powershell
      #   ]
      # ))
      # codium
      zed-editor
    ];
    file = {
      vscode_neovim = {
        source = "${pkgs.pinned.neovim}/bin/nvim";
        target = ".bin/vscode-neovim";
      };
    };
    sessionPath = [ "$HOME/.bin" ];
  };
}
