{ mkDerivation, base, bytestring, fetchgit, stdenv, text }:
mkDerivation {
  pname = "stripe-concepts";
  version = "1.0.2.0";
  src = fetchgit {
    url = "https://github.com/typeclasses/stripe.git";
    sha256 = "02403a6iv0xipvh3nhhzdwajcaa5sh9mdiacwxwm2hdkf7r72fd9";
    rev = "caea9f987101ad2283b0cead73775c1b760fbcaa";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/stripe-concepts; echo source root reset to $sourceRoot";
  libraryHaskellDepends = [ base bytestring text ];
  homepage = "https://github.com/typeclasses/stripe";
  description = "Types for the Stripe API";
  license = stdenv.lib.licenses.mit;
}
