{ mkDerivation, base, criterion, hedgehog, stdenv }:
mkDerivation {
  pname = "grab";
  version = "0.0.0.4";
  sha256 = "44ca2087a4a20d400cc59759d78fca7a946710f894d264b931826b3155aa5679";
  libraryHaskellDepends = [ base ];
  testHaskellDepends = [ base hedgehog ];
  benchmarkHaskellDepends = [ base criterion ];
  homepage = "https://github.com/typeclasses/grab";
  description = "Applicative non-linear consumption";
  license = stdenv.lib.licenses.mit;
}
