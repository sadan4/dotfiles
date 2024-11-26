set -eo pipefail

if [[ -z $1 ]]; then
    echo "You need to provide a remote name";
    echo "Avilable remotes";
    git remote -v;
    exit 1;
fi
URL=$(git remote get-url $1);
URL=${URL/https:\/\//git@};
URL=${URL/\//:};
git remote set-url $1 $URL;