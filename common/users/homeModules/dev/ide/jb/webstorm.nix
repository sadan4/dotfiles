{pkgs, ...}: let
	# https://www.jetbrains.com/webstorm/nextversion
	version = "253.28294.86";
	url = "https://download.jetbrains.com/webstorm/WebStorm-${version}.tar.gz";
	sha256 = "sha256-UQyuc0VSbBmeX+v2N/X3e1EfE6tc13cSU3JpXh/R9H4=";
in {
	imports = [
		../../../unstable.nix
	];
	home = {
		packages = with pkgs.unstable.jetbrains; [
			webstorm
		];
	};
}
