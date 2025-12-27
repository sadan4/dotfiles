{
	lib,
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	openssl,
}:
rustPlatform.buildRustPackage (finalAttrs: {
		pname = "dvm";
		version = "1.2.0";
		src =
			fetchFromGitHub {
				owner = "diced";
				repo = "dvm";
				tag = finalAttrs.version;
				hash = "sha256-6KXo/ek7wJZk8pOKorg4RGDzLJUeH3VyArP/ykl0UDQ=";
			};

		cargoHash = "sha256-AaEo34Fqw58qN/KbAWuzVhEanJZVWm+zKmR2CKwi7+Y=";

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
