{pkgs, ...}: {
    imports = [
        ./unstable.nix
    ];
    home = {
        packages = with pkgs; [
            unstable.prisma
            prisma-engines
            sqlite
        ];
        sessionVariables = {
            PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
            PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
            PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
        };
    };
}
