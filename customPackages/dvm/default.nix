{
	lib,
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	openssl,
}:
rustPlatform.buildRustPackage (finalAttrs: {
		pname = "dvm";
		version = "1.3.0";
		src =
			fetchFromGitHub {
				owner = "diced";
				repo = "dvm";
				tag = "v${finalAttrs.version}";
				hash = "sha256-KMEtXpbyr6nmEWIo/NFbwvNe8DY5sDcJS5ymapAP3sw=";
			};

		cargoHash = "sha256-DSnRRy/dMDyBDmhjMoAvRDzNOs7NeIMb1MTaza1Ei7g=";

		nativeBuildInputs = [
			pkg-config
		];

		buildInputs = [
			openssl
		];

		meta = {
			description = "Discord version manager CLI";
			homepage = "https://github.com/diced/dvm";
			license = lib.licenses.gpl3;
			maintainers = [];
		};
	})
