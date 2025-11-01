{stable, ...}: {
	nixpkgs.overlays = [
		(final: prev: {
				inherit stable;
			})
	];
}
