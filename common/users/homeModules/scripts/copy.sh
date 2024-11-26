command -v xsel > /dev/null
if [[ $? -eq 0 ]]; then
    xsel -ib $@ && exit 0
fi
command -v wslclip > /dev/null
if [[ $? -eq 0 ]]; then
    wslclip $@ && exit 0
fi