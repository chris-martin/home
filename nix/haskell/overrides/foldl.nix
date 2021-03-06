{ mkDerivation, base, bytestring, comonad, containers
, contravariant, criterion, doctest, hashable, lib, mwc-random
, primitive, profunctors, semigroupoids, text, transformers
, unordered-containers, vector
}:
mkDerivation {
  pname = "foldl";
  version = "1.4.11";
  sha256 = "b473aede336a0c4a7d9ac9c13d913e6ff4722ca4015a63fa753dcc46f13d2816";
  libraryHaskellDepends = [
    base bytestring comonad containers contravariant hashable
    mwc-random primitive profunctors semigroupoids text transformers
    unordered-containers vector
  ];
  testHaskellDepends = [ base doctest ];
  benchmarkHaskellDepends = [ base criterion ];
  description = "Composable, streaming, and efficient left folds";
  license = lib.licenses.bsd3;
}
