{ pkgs ? import <nixpkgs> {}, ghc ? pkgs.ghc }:

with pkgs;

let

  latex = texlive.combine {
    inherit (texlive)
      scheme-medium  # An aggegrate base package with bunch of tex packages
      ;
  };

in haskell.lib.buildStackProject {
  name = "default-stack-shell";
  inherit ghc;
  buildInputs = [
    # cairo latex pango
    # leveldb
    pam pcre zlib

    mesa # opengl

    openal freealut

    bzip2 # Needed by bzlib

  ] ++ (with xorg; [libX11 libXi libXrandr libXxf86vm libXcursor libXinerama]);

  # https://github.com/commercialhaskell/stack/issues/2358
  LANG = "en_US.UTF-8";

  # https://github.com/commercialhaskell/stack/commit/568938da
  TMPDIR = "/tmp";
}
