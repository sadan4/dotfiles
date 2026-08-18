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
			unstable.antigravity-cli
			unstable.claude-code
			unstable.opencode
			unstable.opencode-desktop
		];
		shellAliases = {
			cloc = "${pkgs.tokei}/bin/tokei";
		};
	};
}
