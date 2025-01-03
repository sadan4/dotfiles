# use the source luke
# <https://sourcegraph.com/github.com/NixOS/nixpkgs/-/blob/pkgs/development/tools/database/schemaspy/default.nix>
# <https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/maven.section.md>
{ pname, version, src, depsHash, targetJar, renameJar, }:
{ lib, stdenv, callPackage, maven, jdk8, buildMaven, }:
let
  inherit pname version src;

  mavenDeps = stdenv.mkDerivation {
    name = "${pname}-${version}-deps";
    inherit src;

    nativeBuildInputs = [ jdk8 maven ];
    buildPhase = ''
      mvn package \
        -Dmaven.test.skip=true \
        -Dmaven.repo.local=$out \
        -Dmaven.wagon.rto=5000
    '';

    # keep only *.{pom,jar,sha1,nbm} and delete all ephemeral files with lastModified timestamps inside
    installPhase = ''
      find $out -type f \
        -name \*.lastUpdated -or \
        -name resolver-status.properties -or \
        -name _remote.repositories \
        -delete
    '';

    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
    outputHash = depsHash;

    doCheck = false;
  };
in stdenv.mkDerivation {
  inherit pname version src;

  buildInputs = [ jdk8 maven ];
  buildPhase = ''
    runHook preBuild

    mvn package --offline \
      -Dmaven.test.skip=true \
      -Dmaven.repo.local=${mavenDeps.outPath}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm644 target/${targetJar} $out/${renameJar}
    runHook postInstall
  '';
}
