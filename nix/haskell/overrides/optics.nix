{ mkDerivation, array, base, bytestring, containers, criterion
, indexed-profunctors, inspection-testing, lens, mtl, optics-core
, optics-extra, optics-th, QuickCheck, random, stdenv, tasty
, tasty-hunit, tasty-quickcheck, template-haskell, transformers
, unordered-containers, vector
}:
mkDerivation {
  pname = "optics";
  version = "0.3";
  sha256 = "0260b37f8d9975a25a3ce12777c3686e662a7429bcc8648d2ac52c18937c136c";
  libraryHaskellDepends = [
    array base containers mtl optics-core optics-extra optics-th
    transformers
  ];
  testHaskellDepends = [
    base containers indexed-profunctors inspection-testing mtl
    optics-core QuickCheck random tasty tasty-hunit tasty-quickcheck
    template-haskell
  ];
  benchmarkHaskellDepends = [
    base bytestring containers criterion lens transformers
    unordered-containers vector
  ];
  description = "Optics as an abstract interface";
  license = stdenv.lib.licenses.bsd3;
}
