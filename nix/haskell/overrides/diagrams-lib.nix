{ mkDerivation, active, adjunctions, array, base, bytestring
, cereal, colour, containers, criterion, data-default-class
, deepseq, diagrams-core, diagrams-solve, directory, distributive
, dual-tree, exceptions, fetchgit, filepath, fingertree, fsnotify
, hashable, intervals, JuicyPixels, lens, linear, monoid-extras
, mtl, numeric-extras, optparse-applicative, process, profunctors
, QuickCheck, semigroups, stdenv, tagged, tasty, tasty-hunit
, tasty-quickcheck, text, transformers, unordered-containers
}:
mkDerivation {
  pname = "diagrams-lib";
  version = "1.4.3";
  src = fetchgit {
    url = "https://github.com/chris-martin/diagrams-lib";
    sha256 = "1pcjynksv9k47nffhsniy6vcjyxz2symxg6jjms9nfx7bl4n1zdd";
    rev = "da4341dc9f9f8307e0dcb1c346d3b84be292f8f4";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    active adjunctions array base bytestring cereal colour containers
    data-default-class diagrams-core diagrams-solve directory
    distributive dual-tree exceptions filepath fingertree fsnotify
    hashable intervals JuicyPixels lens linear monoid-extras mtl
    optparse-applicative process profunctors semigroups tagged text
    transformers unordered-containers
  ];
  testHaskellDepends = [
    base deepseq diagrams-solve distributive lens numeric-extras
    QuickCheck tasty tasty-hunit tasty-quickcheck
  ];
  benchmarkHaskellDepends = [ base criterion diagrams-core ];
  homepage = "http://diagrams.github.io";
  description = "Embedded domain-specific language for declarative graphics";
  license = stdenv.lib.licenses.bsd3;
}
