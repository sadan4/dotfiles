{ ... }:
let
  NAME = "meyer";
in
{
  imports = [
    (import ../modules/networkManager.nix { inherit NAME; })
  ];
}
