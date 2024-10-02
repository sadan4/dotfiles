{ pkgs, inputs, ... }:
let
  NAME = "meyer";
in
{
  imports = [
    (import ../../systemModules/networkManager.nix { inherit NAME; })
    (import ../../systemModules/sops.nix { inherit NAME; })
    (import ../../systemModules/vm.nix { inherit NAME; })
    (import ../../programs/wireshark.nix { inherit NAME; })
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
    extraSpecialArgs = { inherit inputs; };
    users = {
      "${NAME}" = import ./home.nix;
    };
  };
}
