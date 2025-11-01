{pkgs, ...}: {
	imports = [
		./pinned.nix
		./stable.nix
	];
	home = {
		packages = with pkgs; [
			parsec-bin
			stable.protonvpn-gui
			insomnia
			teamviewer
			filezilla
		];
	};
}
