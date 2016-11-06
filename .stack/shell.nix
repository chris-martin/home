{ pkgs ? import <nixpkgs> {}, ghc ? pkgs.ghc }:

with pkgs;

haskell.lib.buildStackProject {
  name = "default-stack-shell";
  inherit ghc;
  buildInputs = [ zlib ];
  LANG = "en_US.UTF-8";
}
