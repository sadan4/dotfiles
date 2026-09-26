{pkgs, ...}: {
	imports = [
		../stable.nix
	];
	home = {
		packages = with pkgs; [
			shotcut
			pinta
			stable.krita
			gimp
			stable.inkscape
			obs-studio
			peek
			screenkey
			jellyfin-desktop
		];
	};
}
