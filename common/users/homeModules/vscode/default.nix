{pkgs, ...}: {
	imports = [
		./overlays.nix
	];
	# FIXME: this file is unused
	home.packages = with pkgs; [
		vscode-insider
	];
}
