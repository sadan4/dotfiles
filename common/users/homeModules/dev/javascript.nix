{ pkgs, ... }:
let
  node = pkgs.nodejs_22;
in
{
  imports = [
    ../prisma.nix
    ../../../../customPackages
    ../unstable.nix
  ];
  programs = {
    zsh = {
      initExtra = ''
        eval "$(${node}/bin/node --completion-bash)"
      '';
    };
  };
  home = {
    shellAliases = {
      pd = "/home/meyer/dev/ts/pnpm/pnpm/dev/pd.js";
      webpack = "webpack-cli";
      eslintd = "eslint_d";
    };
    packages =
      with pkgs;
      [
        cpkg.chrome-pak-customizer
        lemminx
        deno
        eslint_d
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        typescript
        unstable.eslint
        unstable.corepack_23
        node
        vsce
        esbuild
        unstable.pnpm
      ]
      ++ (with pkgs.nodePackages; [
        webpack-cli
        nodemon
        ts-node
        live-server
      ]);
  };
}
