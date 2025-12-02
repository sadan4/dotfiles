{ pkgs, ... }:
let
  # https://www.jetbrains.com/clion/nextversion
  version = "253.28294.254";
	# https://download.jetbrains.com/cpp/CLion-253.28294.254.tar.gz
  url = "https://download.jetbrains.com/cpp/CLion-${version}.tar.gz";
  sha256 = "sha256-N5SFt31GGZ8uq0LK9h2LFTwo1SdNzEuUOFz3jLvsmq8=";
in
{
  imports = [
    ../../../unstable.nix
  ];
  home = {
    packages = with pkgs.unstable.jetbrains; [
      (clion.overrideAttrs (
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
