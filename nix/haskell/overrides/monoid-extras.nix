{ mkDerivation, base, criterion, fetchgit, groups, semigroupoids
, semigroups, stdenv
}:
mkDerivation {
  pname = "monoid-extras";
  version = "0.5.1";
  src = fetchgit {
    url = "https://github.com/diagrams/monoid-extras.git";
    sha256 = "07qz176w3wvaii3k8cr6sr1nr765qyvxci5bi5izg0b56yj4sbdx";
    rev = "216a82109c38bf0c692b32db11a424bcb0b54f8e";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [ base groups semigroupoids semigroups ];
  benchmarkHaskellDepends = [ base criterion semigroups ];
  description = "Various extra monoid-related definitions and utilities";
  license = stdenv.lib.licenses.bsd3;
}
