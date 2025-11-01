{
	buildNpmPackage,
	fetchFromGitHub,
	lib,
	esbuild,
	buildWebExtension ? false,
}: let
	vencordVersion = "1.9.7";
	gitHash = "d919cd6";
	# this is probably a bad name for this
	sourceHash = "sha256-q2e721U7oCIPISXrnFM4bZY6LhfQiOmb4JhBx68nVwM=";
in
	buildNpmPackage rec {
		pname = "vencord";
		inherit vencordVersion;

		src =
			fetchFromGitHub {
				owner = "Vendicated";
				repo = "Vencord";
				rev = "v${vencordVersion}";
				hash = sourceHash;
			};

		ESBUILD_BINARY_PATH =
			lib.getExe (esbuild.overrideAttrs (final: _: {
						version = "0.15.18";
						src =
							fetchFromGitHub {
								owner = "evanw";
								repo = "esbuild";
								rev = "v${final.version}";
								hash = "sha256-b9R1ML+pgRg9j2yrkQmBulPuLHYLUQvW+WTyR/Cq6zE=";
							};
						vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
					}));

		# Supresses an error about esbuild's version.
		npmRebuildFlags = ["|| true"];

		makeCacheWritable = true;
		npmDepsHash = "sha256-BXGfz4v93veNWoaUSv2w5g/0nDpKJGk6U8m9AQ+O7Jo=";
		npmFlags = ["--legacy-peer-deps"];
		npmBuildScript =
			if buildWebExtension
			then "buildWeb"
			else "build";
		npmBuildFlags = ["--" "--standalone" "--disable-updater"];

		prePatch = ''
			cp ${./package-lock.json} ./package-lock.json
			chmod +w ./package-lock.json
		'';

		VENCORD_HASH = gitHash;
		VENCORD_REMOTE = "${src.owner}/${src.repo}";

		installPhase =
			if buildWebExtension
			then ''
				cp -r dist/chromium-unpacked/ $out
			''
			else ''
				cp -r dist/ $out
			'';

		passthru.updateScript = ./update.sh;

		meta = with lib; {
			name = pname;
			description = "Vencord web extension";
			homepage = "https://github.com/Vendicated/Vencord";
			license = licenses.gpl3Only;
			maintainers = with maintainers; [FlafyDev NotAShelf Scrumplex];
		};
	}
