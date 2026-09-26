{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			onefetch
			hyfetch
			stable.fastfetch
		];
	};
}
