{ pkgs, ... }:
let
  # https://www.jetbrains.com/rust/nextversion/
  version = "253.28294.188";
  url = "https://download.jetbrains.com/rustrover/RustRover-${version}.tar.gz";
  sha256 = "sha256-X4AC9E/40bb4jnxKj912yJiY5vz2EZXf53qNS+Wv3ZE=";
in
{
  imports = [
    ../../../unstable.nix
  ];
  home = {
    packages = with pkgs.unstable.jetbrains; [
      (rust-rover.overrideAttrs (
        _: _: {
          inherit version;
          src = pkgs.fetchurl {
            inherit url sha256;
          };
        }
      ))
    ];
  };
}
