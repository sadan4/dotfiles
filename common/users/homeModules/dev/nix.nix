{pkgs, ...}: {
	home = {
		packages = with pkgs; [
			# formatter
			alejandra
			nixd
		];
	};
}
