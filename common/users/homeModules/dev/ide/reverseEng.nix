{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			ghidra
			# something something license cant be packaged
			# fuck ida
			# ida-free
			cutter
			binaryninja-free
		];
	};
}
