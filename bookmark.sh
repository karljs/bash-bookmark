#!/bin/bash

conf="${HOME}/.config/bookmark.conf"
addflag=false

function print_help {
    echo "usage: cdb [-c] bookmark_name"
}

function add {
    eval name="\$$1"
    if [[ ! -z "$name" ]]; then
        echo "That bookmark already exists. I don't handle that yet"
        return
    else
        echo "$1=\"$PWD\"" >> $conf
        echo "Added $PWD as $1"
    fi
}

function lookup {
    eval name="\$$1"
    if [[ ! -z "$name" ]]; then
        cd \"$name\"
    else
        echo "That bookmark doesn't exist"
        return
    fi
}

# first check if we have a sane number of arguments
if [[ $# -lt 1 || $# -gt 2 ]]; then
    print_help
    return
fi

# parse flags
while getopts ":c" opt; do
    case $opt in
        c)
            addflag=true
            ;;
        \?)
            print_help
            return
            ;;
    esac
done

# check whether config file exists yet
if [[ ! -f $conf ]]; then
    touch $conf
else
    source $conf
fi

# dispatch based on addflag
if $addflag ; then
    add $2
else
    lookup $1
fi
