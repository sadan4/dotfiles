{
	nixpkgs = {
		overlays = [
			(
				pkgs: _: let
					defaultOpts = {
						inherit (pkgs.stdenv.hostPlatform) system;
						config = {
							allowUnfree = true;
						};
					};
					fetch = {
						url,
						sha256,
					}: (import (builtins.fetchTarball {inherit url sha256;}) defaultOpts);
					# TODO: consider using defaultOpts // {...} when extending
				in {
					pinned = {
						neovim =
							(fetch {
									url = "https://github.com/NixOS/nixpkgs/archive/14182c19701221692b84e7428e5b7281b099967a.tar.gz";
									sha256 = "sha256:1x9vqks8j8sfvpw37p9yl476l203b5g6xrc36mdqj5y2h9j2mfag";
								}).neovim;
						# removed for having out of date electron
						etcher =
							(import (builtins.fetchTarball {
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
