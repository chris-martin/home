{ mkDerivation, base, containers, grab, hedgehog, stdenv, text }:
mkDerivation {
  pname = "grab-form";
  version = "0.0.0.4";
  sha256 = "c59605b2f367bbc1324261d518cccdd6ef0ae511d9f74c63d0c94fe926600832";
  libraryHaskellDepends = [ base containers grab text ];
  testHaskellDepends = [ base containers hedgehog text ];
  homepage = "https://github.com/typeclasses/grab";
  description = "Applicative parsers for form parameter lists";
  license = stdenv.lib.licenses.mit;
}
