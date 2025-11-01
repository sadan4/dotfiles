{NAME}: {unstable, ...}: {
	programs = {
		nh = {
			enable = true;
			package = unstable.nh;
			clean = {
				enable = true;
				extraArgs = "--keep-since 4d --keep 3";
			};
			flake = "/home/${NAME}/nixos";
		};
	};
}
