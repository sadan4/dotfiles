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
      # pinned.vscode
      (unstable.vscode.fhsWithPackages (
        pkgs: with pkgs; [
          powershell
        ]
      ))
      # codium
      zed-editor
    ];
  };
}
