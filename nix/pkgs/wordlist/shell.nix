{ pkgs ? import <nixpkgs> {} }:

with pkgs;

haskell.lib.buildStackProject {
  name = "wordlist";
  ghc = haskell.packages.ghc7103.ghc;
  buildInputs = [ ncurses # For intero
                  cabal-install ]; # For stack solver

}
