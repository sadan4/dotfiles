{pkgs, ...}: {
	imports = [
		../unstable.nix
	];
	home = {
		packages = with pkgs; [
			gnumake
			(binutils-unwrapped.override {
					withAllTargets = true;
				})
			# cloc but faster
			tokei
			libtree
			linuxHeaders
			man-pages
			d-spy
			hyperfine
			unstable.github-copilot-cli
		];
		shellAliases = {
			cloc = "${pkgs.tokei}/bin/tokei";
		};
	};
}
