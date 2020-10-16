{ mkDerivation, attoparsec, base, bytestring, cassava, containers
, doctest, fetchgit, foldl, hedgehog, pipes, pipes-bytestring
, pipes-safe, safe-exceptions, stdenv, template-haskell, text
, validation, vector
}:
mkDerivation {
  pname = "dsv";
  version = "0.0.0.1";
  src = fetchgit {
    url = "https://github.com/typeclasses/dsv";
    sha256 = "1swlda2adqnk2wzywds6wza04z95nlaij6k1q6xi98cf33jccljk";
    rev = "3c4ccea5a8fea84bc93cda07dfd92bd408f2be21";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/dsv; echo source root reset to $sourceRoot";
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    attoparsec base bytestring cassava containers foldl pipes
    pipes-bytestring pipes-safe template-haskell text validation vector
  ];
  testHaskellDepends = [
    base bytestring containers doctest foldl hedgehog safe-exceptions
    text vector
  ];
  homepage = "https://github.com/typeclasses/dsv";
  description = "DSV (delimiter-separated values)";
  license = stdenv.lib.licenses.mit;
}
