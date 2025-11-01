{pkgs, ...}: {
	hardware = {
		xpadneo = {
			enable = true;
		};
	};
	programs = {
		steam = {
			enable = true;
			extraCompatPackages = with pkgs; [
				proton-ge-bin
			];
		};
	};
}
