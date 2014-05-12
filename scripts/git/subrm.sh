#!/bin/sh

# Description  :
# Usage        :
# Dependencies :
# Example      :
# Notes        :

warn() {
	echo "$1" >&2
}

die() {
	    warn "$1"
	exit 1
}

MODULE_PATH=`git sublist | grep $1`

# Sanity checking
[ -z $MODULE_PATH ] && die "Submodule doesn't exist"

# Remove the submodule
echo "Removing submodule \"$1\" located in \"$MODULE_PATH/\""
git rm --cached "$MODULE_PATH" 2> /dev/null
git config -f .git/config --remove-section submodule."$MODULE_PATH" 2> /dev/null
git config -f .gitmodules --remove-section submodule."$MODULE_PATH" 2> /dev/null
rm -rf "$MODULE_PATH" 2> /dev/null

# TODO:
# 1. if $1 argument return more than 1 result
# 2. if, by bizarre accident, .git/config doesn't list the submodule and .gitmodules does
# 3. if, by bizarre accident, .git/config doesn't list the submodule and the module still exist in repo