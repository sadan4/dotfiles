set -e
echoe() {
    echo $* 1>&2
}

getTotalRepoCount() {
    echo $(gh api user -q ".total_private_repos + .public_repos")
}

showGuiAndPickRepo() {
    local totalRepos
    totalRepos=$(getTotalRepoCount)
    if [[ $? -ne 0 ]]; then return 1; fi
    local pick
    pick=$(gh repo list -L ${totalRepos} --json nameWithOwner -q ".[] | .nameWithOwner" | fzf \
            --scheme path \
            --cycle \
            --filepath-word \
            --height 50% \
            --reverse \
            --border \
            --border-label " Select Repo To Clone " \
            --color label:bold:cyan \
            --tiebreak index
    )
    if [[ $? -ne 0 ]]; then return 1; fi
    echo ${pick}
}

permuteNames() {
    local name=$1
    IFS="/" read -r user path <<< $name
    local options
    options=("${path}" "${user}-${path}")
    if [[ $? -ne 0 ]]; then return 1; fi
    echo ${options}
}

askCloneName() {
    local repo=$1
    read -ra possibleNames <<< $(permuteNames ${repo})
    local allNames
    allNames=${possibleNames[@]}
    if [[ $? -ne 0 ]]; then return 1; fi
    local pick
    pick=$(echo ${allNames// /\\n} | fzf \
        --query "${possibleNames[1]}" \
        --print-query \
        --height "~50%" \
        --cycle \
        --border \
        --border-label " Name of Dir to Clone Into " \
        --color label:bold:cyan
    )
    # with --print-query we still get a negative exit code if the response was not an option
    if [[ -z $pick ]]; then return 1; fi

    if echo $pick | grep -q "/"; then
        echoe "Your selection: $(echo $pick | grep --color=always "/") has a path delimiter (/) and is invalid";
        return 1;
    fi

    echo ${pick}
}

repo=$(showGuiAndPickRepo)
if [[ $? -ne 0 ]]; then exit 1; fi
USE_SSH=true
if [[ $? -ne 0 ]]; then exit 1; fi
url="ERROR_INVALID_URL"
if [[ $? -ne 0 ]]; then exit 1; fi

if $USE_SSH; then
    url="git@github.com:${repo}.git"
else
    url="https://github.com/${repo}.git"
fi

cloneName=$(askCloneName ${repo})
if [[ $? -ne 0 ]]; then exit 1; fi

gh repo clone ${url} ${cloneName}

echo ${cloneName}
