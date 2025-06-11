#!/usr/bin/env bash
set -eo pipefail

function echoe() {
    echo $@ 1>&2
}

function printUsage() {
    echoe "Usage: ${0} FILE"
    echoe "Unlink a file by copying the original file to the link path"
    echoe "Shorthand for cp -P \$(readlink \$FILE) $FILE"
}

if [[ -z $1 ]]; then
    echoe "${0}: missing file"
    printUsage
    exit 1
fi

cp -P $(readlink $1) $1
