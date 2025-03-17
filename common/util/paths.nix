{ lib, ... }:
let
  array = import ./array.nix { };
in
{
  path = rec {
    split = { path }: builtins.split "/" "${path}";
    removeSuffix = suffix: path: lib.removeSuffix suffix "${path}";
    # ====
    basename =
      {
        path,
        suffix ? "",
      }:
      let
        basename = if array.length (split path) >= 2 then array.tail (split path);
      in
      removeSuffix suffix basename;
    # nix doesnt support windows
    delimiter = ":";
    dirname =
      path:
      let
        ending = basename { inherit path; };
      in
      removeSuffix ending path;
  };
}
