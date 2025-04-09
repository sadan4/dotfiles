{ pkgs, config, ... }:
let
in
{
  imports = [
    # ../../pinned.nix
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
  };
}
