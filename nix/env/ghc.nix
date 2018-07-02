# This is for compiling GHC.

# git clone --recursive git://git.haskell.org/ghc.git

{ pkgs ? import <nixpkgs> {} }:
pkgs.runCommand "ghc-env" {
  buildInputs = [
    pkgs.python3
    pkgs.perl
    pkgs.git
    pkgs.haskellPackages.alex
    pkgs.haskellPackages.happy
    pkgs.haskellPackages.hscolour
    pkgs.haskell.compiler.ghc822
    pkgs.automake
    pkgs.autoconf
  ];
} ""
