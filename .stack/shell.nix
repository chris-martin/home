{ pkgs ? import <nixpkgs> {}, ghc ? pkgs.ghc }:

with pkgs;

haskell.lib.buildStackProject {
  name = "default-stack-shell";
  inherit ghc;
  buildInputs = [ zlib ];

  # https://github.com/commercialhaskell/stack/issues/2358
  LANG = "en_US.UTF-8";

  # https://github.com/commercialhaskell/stack/commit/568938da
  TMPDIR = "/tmp";
}
