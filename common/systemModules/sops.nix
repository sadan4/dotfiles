{ NAME }: { config, inputs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${NAME}/.config/sops/age/keys.txt";
    };
    secrets = {
      password = {
        neededForUsers = true;
      };
    };
  };
  users = {
    users = {
      "${NAME}" = {
        hashedPasswordFile = config.sops.secrets.password.path;
      };
    };
  };
}
