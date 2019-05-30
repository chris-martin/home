{ mkDerivation, aeson, ansi-terminal, base, base-compat, bytestring
, Cabal, containers, deepseq, Diff, directory, exceptions, fetchgit
, filepath, generic-lens, HsYAML, microlens, mtl
, optparse-applicative, parsec, pretty, process, ShellCheck, stdenv
, tasty, tasty-golden, temporary, text, transformers
, unordered-containers
}:
mkDerivation {
  pname = "haskell-ci";
  version = "0.3.20190521";
  src = fetchgit {
    url = "https://github.com/chris-martin/haskell-ci";
    sha256 = "1bk73yss6v9yhnc8a7hr8cxvvizx8iajcyf3m1likfs0j7r2b60f";
    rev = "a42fe87c17d5b423dea6c7fd98412b16f86743f9";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base base-compat bytestring Cabal containers deepseq
    directory exceptions filepath generic-lens HsYAML microlens mtl
    optparse-applicative parsec pretty process ShellCheck temporary
    text transformers unordered-containers
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    ansi-terminal base bytestring Diff directory filepath tasty
    tasty-golden transformers
  ];
  doHaddock = false;
  homepage = "https://haskell-ci.rtfd.org/";
  description = "Cabal package script generator for Travis-CI";
  license = stdenv.lib.licenses.bsd3;
}
