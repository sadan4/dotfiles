{ config, pkgs }: rec {
  dev = {
    env = common.env // {
      PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
      PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
      PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    };
    path = common.path ++ [

    ];
    aliases = common.aliases // {
      lg = "lazygit";
    };
  };
  common = {
    env = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MADWIDTH = "999";
      SSH_ASKPASS_REQUIRE = "prefer";
    };
    path = [
      "$HOME/.local/bin"
    ];
    aliases = {
      paste = "xsel -ob || wslclip -g";
      copy = "xsel -ib || wslclip";
      b = "/home/${config.home.username}/nixos/build";
    };
  };

}
