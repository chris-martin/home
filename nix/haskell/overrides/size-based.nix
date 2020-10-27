{ mkDerivation, base, dictionary-sharing, fetchgit, stdenv
, template-haskell, testing-type-modifiers
}:
mkDerivation {
  pname = "size-based";
  version = "0.1.2.0";
  src = fetchgit {
    url = "https://github.com/chris-martin/sized-functors.git";
    sha256 = "1i7ia52c2zar9sl5jx6q32117piiz05m4pvckw3bcb22ka4fqi6s";
    rev = "17936cac88788c3890de1d086b30d500dc2741e3";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base dictionary-sharing template-haskell testing-type-modifiers
  ];
  description = "Sized functors, for size-based enumerations";
  license = stdenv.lib.licenses.bsd3;
}
