# https://lazamar.co.uk/nix-versions/
{ pkgs, config }:
{
  # 1.89.1
  vscode = (import
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
    }).vscode;
  etcher = (import
    (builtins.fetchGit {
      # Descriptive name to make the store path easier to identify
      name = "my-old-revision";
      url = "https://github.com/NixOS/nixpkgs/";
      ref = "refs/heads/nixpkgs-unstable";
      rev = "336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3";
    })
    {
      system = pkgs.system;
      config = {
        permittedInsecurePackages = [ "electron-19.1.9" ];
      };
    }).etcher;
}
