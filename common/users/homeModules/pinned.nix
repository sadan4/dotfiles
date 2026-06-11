{
	nixpkgs = {
		overlays = [
			(
				pkgs: _: {
					pinned = {
						# removed for having out of date electron
						etcher =
							(import (fetchTarball {
										url = "https://github.com/NixOS/nixpkgs/archive/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3.tar.gz";
										sha256 = "sha256:0v8vnmgw7cifsp5irib1wkc0bpxzqcarlv8mdybk6dck5m7p10lr";
									})
								{
									inherit (pkgs.stdenv.hostPlatform) system;
									config = {
										permittedInsecurePackages = ["electron-19.1.9"];
									};
								}).etcher;
					};
				}
			)
		];
	};
}
