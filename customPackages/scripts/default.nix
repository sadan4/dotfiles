{
	stdenv,
	git,
	nodejs,
	pnpm,
	lib,
	useLocal ? false,
	fetchFromGitHub,
}:
stdenv.mkDerivation (finalAttrs: {
		pname = "scripts";
		version = "0.0.1";
		nativeBuildInputs = [
			git
			nodejs
			pnpm.configHook
		];
		buildPhase = ''
			runHook preBuild
			pnpm run build
			runHook postBuild
		'';
		installPhase = ''
			runHook preInstall

			cp -r dist $out

			runHook postInstall
		'';
		src =
			if useLocal
			then ./.
			else
				fetchFromGitHub {
					owner = "sadan4";
					repo = "scripts";
					rev = "cd250afb7d55e50f729de82246dd746ab7e7d266";
					hash = lib.fakeHash;
				};
		pnpmDeps =
			pnpm.fetchDeps {
				inherit (finalAttrs) pname src;
				fetcherVersion = 1;
				hash = "sha256-mN/bGYBDJ2fdaJ7USyQhvpAUj0MxC0L+L1vS54gZBww=";
			};
		meta = {
			description = "personal scripts for the various things";
			homepage = "https://sadan.zip";
			license = lib.licenses.cc0;
		};
	})
