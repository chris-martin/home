#!/usr/bin/env bash

set -e

echo "$0: Initializing nixpkgs git repository"

git init nixpkgs
cd nixpkgs

echo "$0: Adding remotes"

add-remote () {
    git remote add "$1" "$2" || git remote set-url "$1" "$2"
}

add-remote origin git@github.com:chris-martin/nixpkgs.git
# add-remote origin https://github.com/chris-martin/nixpkgs.git

add-remote upstream https://github.com/NixOS/nixpkgs.git
add-remote channels https://github.com/NixOS/nixpkgs-channels.git

echo "$0: Fetching from remotes"

git fetch --all

echo "$0: Setting up git branches"

git branch master --set-upstream-to origin/master
git branch unstable --set-upstream-to origin/unstable
git branch release/16.09 --set-upstream-to origin/release/16.09
git branch release/17.03 --set-upstream-to origin/release/17.03

echo "$0: Setting up git worktrees"

git checkout --detach

git worktree add ../path/master master || echo "$0: Skipping"
git worktree add ../path/unstable unstable || echo "$0: Skipping"
git worktree add ../path/release-16.09 release/16.09 || echo "$0: Skipping"
git worktree add ../path/release-17.03 release/17.03 || echo "$0: Skipping"
