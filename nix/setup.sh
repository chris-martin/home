#!/usr/bin/env bash

set -e

script="$0"

print () {
    echo "$script: $1"
}

#-------------------------------------------------------------------------------

print "Initializing nixpkgs git repository"

git init path/master
cd path/master

#-------------------------------------------------------------------------------

print "Adding remotes"

add-remote () {
    git remote add "$1" "$2" || git remote set-url "$1" "$2"
}

add-remote origin git@github.com:chris-martin/nixpkgs.git
# add-remote origin https://github.com/chris-martin/nixpkgs.git

add-remote upstream https://github.com/NixOS/nixpkgs.git
add-remote channels https://github.com/NixOS/nixpkgs-channels.git

#-------------------------------------------------------------------------------

print "Fetching from remotes"

git fetch --all

#-------------------------------------------------------------------------------

print "Setting up git branches"

add-branch () {
    git branch "$1" "$2" || print "Skipping"
}

add-branch master origin/master
add-branch unstable origin/unstable
add-branch release/16.09 origin/release/16.09
add-branch release/17.03 origin/release/17.03

#-------------------------------------------------------------------------------

print "Setting up git worktrees"

add-worktree () {
    git worktree add "$1" "$2" || print "Skipping"
}

add-worktree ../unstable unstable
add-worktree ../release-16.09 release/16.09
add-worktree ../release-17.03 release/17.03
