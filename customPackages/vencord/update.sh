#!/usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq common-updater-scripts prefetch-npm-deps nodejs perl
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

# update-source-version vencord "${latestTag#v}"

perl -i -pe "s/(?<=gitHash = \")\w{7}(?=\";)/${gitHash:0:7}/" ./default.nix
perl -i -pe "s/(?<=npmDepsHash = \")sha256-.*(?=\";)/${npmDepsHash}/" ./default.nix
perl -i -pe "s/(?<=version = \")(\d.?){0,4}(?=\")/${latestTag:1}/" ./default.nix
cp "$tempDir/package-lock.json" "$pkgDir/package-lock.json"
