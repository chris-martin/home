#!/usr/bin/env bash

nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --add https://nixos.org/channels/nixos-17.09 release-17.09
nix-channel --add https://nixos.org/channels/nixos-18.03 release-18.03
nix-channel --add https://nixos.org/channels/nixos-18.09 release-18.09
