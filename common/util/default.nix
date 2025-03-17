{ lib, ... }:
let
  util =
    (import ./modules.nix { }) // (import ./array.nix { }) // (import ./paths.nix { inherit lib; });
in
{
  _module.args = {
    inherit util;
  };
  home-manager.extraSpecialArgs = {
    inherit util;
  };
}
