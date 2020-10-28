{ mkDerivation, adjunctions, base, containers, distributive
, dual-tree, fetchgit, lens, linear, monoid-extras, mtl
, profunctors, semigroups, stdenv, unordered-containers
}:
mkDerivation {
  pname = "diagrams-core";
  version = "1.4.2";
  src = fetchgit {
    url = "https://github.com/chris-martin/diagrams-core";
    sha256 = "1x335pwvw6m44w2ykxdjq9dfck7pqyi1271qrwpfvq9g75j2871a";
    rev = "1cb7e0a1745053c37def2f09b0e68268583dada4";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    adjunctions base containers distributive dual-tree lens linear
    monoid-extras mtl profunctors semigroups unordered-containers
  ];
  homepage = "http://projects.haskell.org/diagrams";
  description = "Core libraries for diagrams EDSL";
  license = stdenv.lib.licenses.bsd3;
}
