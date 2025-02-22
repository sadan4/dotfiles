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
    (import ../../systemModules/sops.nix { inherit NAME; })
  ];
  users = {
    users = {
      "${NAME}" = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
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
    extraSpecialArgs = {
      inherit inputs stable unstable;
    };
    users = {
      "${NAME}" = import ./home.nix;
    };
  };
}
