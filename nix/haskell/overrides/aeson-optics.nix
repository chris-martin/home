{ mkDerivation, aeson, attoparsec, base, base-compat, bytestring
, optics-core, optics-extra, scientific, stdenv, text
, unordered-containers, vector
}:
mkDerivation {
  pname = "aeson-optics";
  version = "1.1.0.1";
  sha256 = "c7555096900d1c9bb18b1a5c8697976e6dc8268a9ec1c6dbb9abf0431941d1dd";
  revision = "3";
  editedCabalFile = "1hxkahjf6znybqiv622n3syn5pp1a6jdpzq8ryrq9y45yczg82pi";
  libraryHaskellDepends = [
    aeson attoparsec base base-compat bytestring optics-core
    optics-extra scientific text unordered-containers vector
  ];
  homepage = "http://github.com/phadej/aeson-optics";
  description = "Law-abiding optics for aeson";
  license = stdenv.lib.licenses.mit;
}
