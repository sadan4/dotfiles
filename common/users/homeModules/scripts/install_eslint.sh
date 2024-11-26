set -x
cp $HOME/.config/.eslintrc.json .
pkgs=("@stylistic/eslint-plugin" "@typescript-eslint/eslint-plugin")
if [[ -z $1 ]]; then
    echo please specify npm, pnpm, or yarn
    exit 1
fi
for i in "${pkgs[@]}"; do
`$1 i -D $i`
done