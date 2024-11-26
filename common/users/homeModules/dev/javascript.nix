{pkgs, ...}: {
    imports = [
        ../prisma.nix
    ]
    home = {
        packages = with pkgs; [
            deno
            eslint_d
            vscode-langservers-extracted
            nodePackages_latest.typescript-language-server
            typescript
            eslint
            corepack_22
            nodejs_22
        ] ++ (with pkgs.nodePackages; [
            nodemon
            ts-node
            pnpm
            live-server
        ]);
    }
}