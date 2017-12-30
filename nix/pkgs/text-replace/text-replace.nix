{ mkDerivation, base, containers, fetchgit, hedgehog
, neat-interpolation, optparse-applicative, parsec, stdenv, text
}:
mkDerivation {
  pname = "text-replace";
  version = "0.0.0.1";
  src = fetchgit {
    url = "https://github.com/chris-martin/text-replace";
    sha256 = "1q6w40pkch8bbpc1mb8f2lx115d5yk60ycdpm4y558df87d7fhfw";
    rev = "d19857a64b09210207cb864620da34e3a34650c8";
  };
  postUnpack = "sourceRoot+=/text-replace; echo source root reset to $sourceRoot";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base containers ];
  executableHaskellDepends = [ base optparse-applicative parsec ];
  testHaskellDepends = [ base hedgehog neat-interpolation text ];
  homepage = "https://github.com/chris-martin/text-replace";
  description = "Simple text replacements from a list of search/replace pairs";
  license = stdenv.lib.licenses.asl20;
}
