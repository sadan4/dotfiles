{pkgs, ...}: {
	imports = [
		./stable.nix
	];
	home = {
		packages = with pkgs; [
			obsidian
			pandoc
			stable.libreoffice
		];
	};
}
