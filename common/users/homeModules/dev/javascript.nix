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
      initContent = ''
        eval "$(${node}/bin/node --completion-bash)"
        eval "$(${node}/bin/npm completion)"
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
        bun
        eslint_d
        vscode-langservers-extracted
        nodePackages_latest.typescript-language-server
        electron-fiddle
        typescript
        unstable.eslint
        unstable.corepack_24
        node
        vsce
        esbuild
        asar
        # read electron crash dumps
        breakpad
      ]
      ++ (with pkgs.nodePackages; [
        webpack-cli
        nodemon
        ts-node
        live-server
      ]);
  };
}
