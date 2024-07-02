{ buildNpmPackage
, fetchFromGitHub
, lib
, esbuild
, buildWebExtension ? false
}:
let
  vencordVersion = "1.9.3";
  gitHash = "484d70f";
  # this is probably a bad name for this
  sourceHash = "sha256-dtskvmrDOhOWBh6TLDxM22ArAaCj8wXdhBvyexkS4Qs=";
in
buildNpmPackage rec {
  pname = "vencord";
  inherit vencordVersion;

  src = fetchFromGitHub {
    owner = "Vendicated";
    repo = "Vencord";
    rev = "v${vencordVersion}";
    hash = sourceHash;
  };

  ESBUILD_BINARY_PATH = lib.getExe (esbuild.overrideAttrs (final: _: {
    version = "0.15.18";
    src = fetchFromGitHub {
      owner = "evanw";
      repo = "esbuild";
      rev = "v${final.version}";
      hash = "sha256-b9R1ML+pgRg9j2yrkQmBulPuLHYLUQvW+WTyR/Cq6zE=";
    };
    vendorHash = "sha256-+BfxCyg0KkDQpHt/wycy/8CTG6YBA/VJvJFhhzUnSiQ=";
  }));

  # Supresses an error about esbuild's version.
  npmRebuildFlags = [ "|| true" ];

  makeCacheWritable = true;
  npmDepsHash = "sha256-MYadxXRY7ZtOY7t73YivbB/Z3bOudi1a3gZemrQwh7k=";
  npmFlags = [ "--legacy-peer-deps" ];
  npmBuildScript = if buildWebExtension then "buildWeb" else "build";
  npmBuildFlags = [ "--" "--standalone" "--disable-updater" ];

  prePatch = ''
    cp ${./package-lock.json} ./package-lock.json
    chmod +w ./package-lock.json
  '';

  VENCORD_HASH = gitHash;
  VENCORD_REMOTE = "${src.owner}/${src.repo}";

  installPhase =
    if buildWebExtension then ''
      cp -r dist/chromium-unpacked/ $out
    '' else ''
      cp -r dist/ $out
    '';

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "Vencord web extension";
    homepage = "https://github.com/Vendicated/Vencord";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ FlafyDev NotAShelf Scrumplex ];
  };
}
