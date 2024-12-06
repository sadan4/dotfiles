{ NAME }: { ... }: {
  virtualisation = {
    docker = {
      rootless = {
        enable = true;
      };
      enable = true;
    };
  };
  environment = {
    sessionVariables = {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
    };
  };
}
