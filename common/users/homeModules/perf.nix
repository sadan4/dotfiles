{pkgs, ...}: {
	nixpkgs = {
		overlays = [
			(final: prev: {
					perf =
						prev.perf.overrideAttrs (prev: {
								nativeBuildInputs = prev.nativeBuildInputs ++ [final.libllvm];
								buildInputs = prev.buildInputs ++ [final.libllvm];
							});
				})
		];
	};
	home = {
		packages = with pkgs; [
			perf
			speedscope
			inferno
		];
	};
}
