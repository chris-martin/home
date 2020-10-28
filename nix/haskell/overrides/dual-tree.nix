{ mkDerivation, base, fetchgit, monoid-extras, newtype-generics
, QuickCheck, semigroups, stdenv, testing-feat
}:
mkDerivation {
  pname = "dual-tree";
  version = "0.2.2.1";
  src = fetchgit {
    url = "https://github.com/chris-martin/dual-tree.git";
    sha256 = "1xlxr248sjvh6yv2nswivdg4qsm5530i8dp0h2pzqpxns04inqg9";
    rev = "f8bfbe9226f277004ac8a3af781175ad8207684f";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base monoid-extras newtype-generics semigroups
  ];
  testHaskellDepends = [
    base monoid-extras QuickCheck semigroups testing-feat
  ];
  description = "Rose trees with cached and accumulating monoidal annotations";
  license = stdenv.lib.licenses.bsd3;
}
