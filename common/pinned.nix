# https://lazamar.co.uk/nix-versions/
{ pkgs, config }:
let
  # 1.89.1
  vsc_pkgs = import
    (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "my-old-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb";
    })
    {
      system = pkgs.system;
      config = {
        allowUnfree = true;
      };
    };
  a = vsc_pkgs.vscode;
in
{
  vscode = a;
}
