command -v xsel > /dev/null
if [[ $? -eq 0 ]]; then
    xsel -ob && exit 0
fi
command -v wslclip > /dev/null
if [[ $? -eq 0 ]]; then
    wslclip -g && exit 0
fi