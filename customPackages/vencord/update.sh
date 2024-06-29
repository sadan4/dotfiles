#!/usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq nix-prefetch-github common-updater-scripts prefetch-npm-deps nodejs perl
set -eou pipefail

pkgDir="$(dirname "$(readlink -f "$0")")"

tempDir=$(mktemp -d)

ghTags=$(curl ${GITHUB_TOKEN:+" -u \":$GITHUB_TOKEN\""} "https://api.github.com/repos/Vendicated/Vencord/tags")
latestTag=$(echo "$ghTags" | jq -r .[0].name)
gitHash=$(echo "$ghTags" | jq -r .[0].commit.sha)

pushd "$tempDir"
curl "https://raw.githubusercontent.com/Vendicated/Vencord/$latestTag/package.json" -o package.json
npm install --legacy-peer-deps -f

npmDepsHash=$(prefetch-npm-deps ./package-lock.json)
popd

# FIXME: why doesnt this work
# update-source-version vencord "${latestTag#v}"
set -x
Hash=$(nix-prefetch-github Vendicated Vencord | jq -r .hash)

perl -i -pe "s#(?<=sourceHash = \").*(?=\")#${Hash}#" ./package.nix
perl -i -pe "s/(?<=gitHash = \")\w{7}(?=\";)/${gitHash:0:7}/" ./package.nix
perl -i -pe "s#(?<=npmDepsHash = \")sha256-.*(?=\";)#${npmDepsHash}#" ./package.nix
perl -i -pe "s/(?<=version = \")(\d.?){0,4}(?=\")/${latestTag:1}/" ./package.nix
cp "$tempDir/package-lock.json" "$pkgDir/package-lock.json"
