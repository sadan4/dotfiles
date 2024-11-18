{ config, pkgs, cpkg }:
rec {
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
      sd = ''lsusb | grep Elgato | grep --perl-regexp "(?<=Device 0{0,10})[1-9]+" --only-matching | xargs printf "usb.device_address eq %s" | copy'';
    };
  };
  common = {
    env = {
      LG_CONFIG_FILE = "/home/${config.home.username}/.config/lazygit/tokyonight_night.conf";
      BAT_THEME = "Dracula";
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
      MADWIDTH = "999";
      SSH_ASKPASS_REQUIRE = "prefer";
    };
    path = [
      "$HOME/.local/bin"
    ];
    aliases = {
      #      paste = "xsel -ob || wslclip -g";
      #      copy = "xsel -ib || wslclip";
      b = "/home/${config.home.username}/nixos/build";
    };
  };

}
