{
  pkgs,
  inputs,
  stable,
  unstable,
  ...
}:
let
  NAME = "meyer";
in
{
  imports = [
    (import ../../systemModules/networkManager.nix { inherit NAME; })
    (import ../../systemModules/sops.nix { inherit NAME; })
    (import ../../systemModules/vm.nix { inherit NAME; })
    (import ../../systemModules/razer.nix { inherit NAME; })
    (import ../../systemModules/docker.nix { inherit NAME; })
    (import ../../systemModules/nixHelper.nix { inherit NAME; })
    (import ../../programs/wireshark.nix { inherit NAME; })
    (import ../../programs/kanata.nix { inherit NAME; })
  ] ++ [
    (builtins.trace "importing nginx.nix" import ../docker/vw/nginx.nix)
  ];
  users = {
    users = {
      "${NAME}" = {
        isNormalUser = true;
        extraGroups = [
          "wheel" # Enable ‘sudo’ for the user.
          "audio"
          "sound"
          "video"
          "input"
          "tty"
          "plugdev"
        ];
        shell = pkgs.zsh;
      };
    };
  };
  home-manager = {
    extraSpecialArgs = { inherit inputs stable unstable; };
    users = {
      "${NAME}" =
        { ... }:
        {
          imports = [
            ../docker/vw
            ./home.nix
          ];
        };
    };
  };
}
