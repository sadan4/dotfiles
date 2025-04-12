{ ... }:
{
  nixpkgs = {
    overlays = [
      # self: super:
      # pkgs: _:
      (
        pkgs: _:
        let
          defaultOpts = {
            system = pkgs.system;
            config = {
              allowUnfree = true;
            };
          };
        in
        {
          # extend packages here
          pinned = {
            # 1.89.1
            vscode =
              (import (builtins.fetchGit {
                # Descriptive name to make the store path easier to identify
                name = "pinned-vscode";
                url = "https://github.com/NixOS/nixpkgs/";
                ref = "refs/heads/nixpkgs-unstable";
                rev = "0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb";
              }) defaultOpts).vscode;
            neovim =
              (import (builtins.fetchGit {
                # Descriptive name to make the store path easier to identify
                name = "my-old-revision";
                url = "https://github.com/NixOS/nixpkgs/";
                ref = "refs/heads/nixpkgs-unstable";
                rev = "0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb";
              }) defaultOpts).neovim;
            # removed for having out of date electron
            etcher =
              (import
                (builtins.fetchGit {
                  # Descriptive name to make the store path easier to identify
                  name = "pinned-etcher";
                  url = "https://github.com/NixOS/nixpkgs/";
                  ref = "refs/heads/nixpkgs-unstable";
                  rev = "336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3";
                })
                {
                  system = pkgs.system;
                  config = {
                    permittedInsecurePackages = [ "electron-19.1.9" ];
                  };
                }
              ).etcher;
            # support non-updated plugins
            idea-ultimate =
              (import (builtins.fetchGit {
                name = "pinned-idea-ultimate";
                url = "https://github.com/NixOS/nixpkgs/";
                ref = "refs/heads/nixpkgs-unstable";
                rev = "05bbf675397d5366259409139039af8077d695ce";
              }) defaultOpts).jetbrains.idea-ultimate;
            gdb =
              (import (builtins.fetchGit {
                # Descriptive name to make the store path easier to identify
                name = "my-old-revision";
                url = "https://github.com/NixOS/nixpkgs/";
                ref = "refs/heads/nixpkgs-unstable";
                rev = "05bbf675397d5366259409139039af8077d695ce";
              }) defaultOpts).gdb;

          };
        }
      )
    ];
  };
}
