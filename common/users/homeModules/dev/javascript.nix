{ pkgs, ... }: {
  imports = [
    ../prisma.nix
    ../../../../customPackages
    ../unstable.nix
  ];
  home = {
    shellAliases = {
        pd = "/home/meyer/dev/ts/pnpm/pnpm/dev/pd.js";
        webpack = "webpack-cli";
    };
    packages = with pkgs;
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
        nodejs_22
        vsce
        esbuild
        unstable.pnpm
      ] ++ (with pkgs.nodePackages; [
        webpack-cli
        nodemon
        ts-node
        live-server
      ]);
  };
}
