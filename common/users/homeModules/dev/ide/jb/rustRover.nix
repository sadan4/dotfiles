{pkgs, ...}: {
	imports = [
		../../../unstable.nix
	];
	home = {
		packages = with pkgs.unstable.jetbrains; [
			rust-rover
		];
	};
}
