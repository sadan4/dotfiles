{ config, ... }:
{
  imports = [
    ../../homeModules/sops.nix
  ];
  home = {
    file = {
      couchdb_compose = {
        source = ./docker-compose.yaml;
        target = "./src/obsidian/docker-compose.yaml";
      };
      # Docker is stupid and wont read a symlinked Dockerfile
      # couchdb_dockerfile = {
      #   source = ./Dockerfile;
      #   target = "./src/obsidian/Dockerfile";
      # };
      # not only will it not load a symlinked dockerfile, it refuses to copy any symlinked file
      # couchdb_vm-args = {
      #   source = ./vm.args;
      #   target = "./src/obsidian/vm.args";
      # };
      # couchdb_docker-default = {
      #   source = ./10-docker-default.ini;
      #   target = "./src/obsidian/10-docker-default.ini";
      # };
      # couchdb_docker-entrypoint-sh = {
      #   source = ./docker-entrypoint.sh;
      #   target = "./src/obsidian/docker-entrypoint.sh";
      # };
    };
  };
  systemd = {
    user = {
      tmpfiles = {
        rules = [
          "C /home/${config.home.username}/src/obsidian/Dockerfile 0444 - - - ${./Dockerfile}"
          "C /home/${config.home.username}/src/obsidian/docker-entrypoint.sh 0555 - - - ${./docker-entrypoint.sh}"
          "C /home/${config.home.username}/src/obsidian/10-docker-default.ini 0444 - - - ${./10-docker-default.ini}"
          "C /home/${config.home.username}/src/obsidian/vm.args 0444 - - - ${./vm.args}"
          # root is needed to +i
          # "h /home/${config.home.username}/src/obsidian/Dockerfile - - - - i"
          # "h /home/${config.home.username}/src/obsidian/docker-entrypoint.sh - - - - i"
          # "h /home/${config.home.username}/src/obsidian/10-docker-default.ini - - - - i"
          # "h /home/${config.home.username}/src/obsidian/vm.args - - - - i"
        ];
      };
    };
  };
  sops = {
    secrets = {
      couchdb_env = {
        format = "dotenv";
        sopsFile = ./couchdb.env;
        path = "/home/${config.home.username}/src/obsidian/couchdb.env";
      };
      # encrypted because it has a hashed password
      couchdb_docker-ini = {
        format = "ini";
        sopsFile = ./docker.ini;
        path = "/home/${config.home.username}/src/obsidian/docker.ini";
      };
    };
  };
}
