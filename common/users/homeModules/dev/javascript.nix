{pkgs, unstable, ...}: {
    imports = [
        ../prisma.nix
    ];
    home = {
        packages = with pkgs; [
            lemminx
            deno
            eslint_d
            vscode-langservers-extracted
            nodePackages_latest.typescript-language-server
            typescript
            unstable.eslint
            corepack_22
            nodejs_22
        ] ++ (with pkgs.nodePackages; [
            nodemon
            ts-node
            pnpm
            live-server
        ]);
    };
}
