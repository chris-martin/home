{ pkgs ? import <nixpkgs> {} }:

with pkgs;

haskell.lib.buildStackProject {
  name = "choose";
  ghc = haskell.packages.ghc7103.ghc;
  buildInputs = [ ncurses # For intero
                  cabal-install ]; # For stack solver

}
