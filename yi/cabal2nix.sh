#!/usr/bin/env bash

cabal2nix . | sed 's#src = ./.;#src = builtins.filterSource (path: type: (builtins.substring 0 1 (baseNameOf path) != ".") \&\& (baseNameOf path != "yi.nix")) ./.;#' > yi.nix
