{ mkDerivation, base, bifunctors, directory, doctest, fetchgit
, linear, semigroups, stdenv, vector
}:
mkDerivation {
  pname = "active";
  version = "0.3";
  src = fetchgit {
    url = "https://github.com/diagrams/active";
    sha256 = "1a3dz3nz7k2ikplil44cfv0dd90aymvs0fqx79p6qfwh6jykgk5l";
    rev = "3976b0e7bfd5c3e83a828bbc7164cd640261e12c";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base bifunctors linear semigroups vector
  ];
  testHaskellDepends = [
    base directory doctest linear semigroups vector
  ];
  description = "An EDSL for time-varying values";
  license = stdenv.lib.licenses.bsd3;
}
