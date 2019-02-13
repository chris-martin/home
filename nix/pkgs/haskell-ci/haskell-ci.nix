{ mkDerivation, ansi-terminal, base, base-compat, bytestring, Cabal
, containers, deepseq, Diff, directory, fetchgit, filepath
, generic-lens, microlens, optparse-applicative, parsec, pretty
, ShellCheck, stdenv, tasty, tasty-golden, transformers
}:
mkDerivation {
  pname = "haskell-ci";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/haskell-CI/haskell-ci.git";
    sha256 = "1qlr45jbvnsvawb0mc7958i0p881dkvprrwlz5nsfl38m0yd7cjv";
    rev = "7302183ac70d3a6a4581e8adee88789b626c6b9d";
    fetchSubmodules = true;
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base base-compat bytestring Cabal containers deepseq directory
    filepath generic-lens microlens optparse-applicative parsec pretty
    ShellCheck transformers
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    ansi-terminal base bytestring Diff directory filepath tasty
    tasty-golden transformers
  ];
  doCheck = false;
  homepage = "http://haskell-ci.rtfd.org/";
  description = "Cabal package script generator for Travis-CI";
  license = stdenv.lib.licenses.bsd3;
}
