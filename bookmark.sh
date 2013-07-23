#!/bin/bash

conf="${HOME}/.config/bookmark.conf"

addflag=false
delflag=false

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

function del {
    eval name="\$$1"
    if [[ ! -z "$name" ]]; then        
        contents=$(grep -v "^$1=" < $conf)       
        echo $contents > $conf
        unset $1
        return
    else
        echo "Can't delete a bookmark that doesn't exist."
    fi    
}

function lookup {
    eval name="\$$1"
    if [[ ! -z "$name" ]]; then
        cd "$name"
    else
        echo "That bookmark doesn't exist."
        return
    fi
}

# first check if we have a sane number of arguments
if [[ $# -lt 1 || $# -gt 2 ]]; then
    print_help
    return
fi

# check whether config file exists yet
if [[ ! -f $conf ]]; then
    touch $conf
else
    source $conf
fi

# parse flags
OPTIND=1
while getopts ":cd" opt; do
    case $opt in
        c)
            addflag=true
            ;;
        d)
            delflag=true
            ;;
        \?)
            print_help
            return
            ;;
    esac
done

# dispatch based on addflag
if $addflag ; then
    add $2
elif $delflag ; then
    del $2
else
    lookup $1
fi
