echo PATH: $PATH 2>&1
command -v xsel > /dev/null
if [[ $? -eq 0 ]]; then
    xsel -ob && exit 0
    exit 0
fi
command -v wslclip > /dev/null
if [[ $? -eq 0 ]]; then
    wslclip -g && exit 0
    exit 0
fi

echo "failed to find clipboard command. install xsel or wslclip"
exit 1
