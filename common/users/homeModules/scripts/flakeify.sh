if [ ! -e flake.nix ]; then
    nix flake new -t github:sadan4/direnvTemplate .
    direnv allow
elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
fi
${EDITOR:-vim} flake.nix
