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
  imports =
    [ ]
    ++ [
      (import ../../systemModules/sops.nix { inherit NAME; })
      (import ../../systemModules/networkManager.nix { inherit NAME; })
      (import ../../systemModules/docker.nix { inherit NAME; })
      (import ../../systemModules/nixHelper.nix { inherit NAME; })
    ]
    ++ [
      ../docker/vw/nginx.nix
      ../docker/obsidian/nginx.nix
      ../docker/flaresolverr
      ../docker/sonarr
      ../docker/radarr
      ../docker/prowlarr
      ../docker/qbit/nginx.nix
    ];
  users = {
    users = {
      "${NAME}" = {
        isNormalUser = true;
        linger = true;
        extraGroups = [
          "wheel"
          "audio"
          "sound"
          "video"
          "input"
          "tty"
          "plugdev"
          "docker"
        ];
        shell = pkgs.zsh;
      };
    };
  };
  home-manager = {
    extraSpecialArgs = {
      inherit inputs stable unstable;
    };
    users = {
      "${NAME}" = (
        { ... }:
        {
          imports = [
            ../docker/vw
            ../docker/obsidian
            ../docker/qbit
            ./home.nix
          ];
        }
      );
    };
  };
}
