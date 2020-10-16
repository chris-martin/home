{ mkDerivation, aeson, base, bytestring, fetchgit, lens, stdenv
, stripe-concepts, text, unordered-containers, wreq
}:
mkDerivation {
  pname = "stripe-wreq";
  version = "1.0.1.0";
  src = fetchgit {
    url = "https://github.com/typeclasses/stripe.git";
    sha256 = "02403a6iv0xipvh3nhhzdwajcaa5sh9mdiacwxwm2hdkf7r72fd9";
    rev = "caea9f987101ad2283b0cead73775c1b760fbcaa";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/stripe-wreq; echo source root reset to $sourceRoot";
  libraryHaskellDepends = [
    aeson base bytestring lens stripe-concepts text
    unordered-containers wreq
  ];
  homepage = "https://github.com/typeclasses/stripe";
  description = "Use the Stripe API via Wreq";
  license = stdenv.lib.licenses.mit;
}
