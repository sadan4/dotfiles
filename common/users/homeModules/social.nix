{pkgs, ...}: let
	dvm = pkgs.cpkg.dvm;
in {
	imports = [
		./arrpc.nix
		./unstable.nix
		../../../customPackages
	];
	home = {
		packages = with pkgs; [
			legcord
			element-desktop
			signal-desktop
			unstable.vesktop
			dvm
		];
	};
	programs = {
		zsh = {
			initContent = ''
				eval "$(${dvm}/bin/dvm completions zsh)"
			'';
		};
	};
}
