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
        corepack_22
        nodejs_22
        vsce
        esbuild
      ] ++ (with pkgs.nodePackages; [
        webpack-cli
        nodemon
        ts-node
        pnpm
        live-server
      ]);
  };
}
