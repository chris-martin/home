{ mkDerivation, array, base, containers, indexed-profunctors
, stdenv, transformers
}:
mkDerivation {
  pname = "optics-core";
  version = "0.3.0.1";
  sha256 = "30115bd9b2adc4e7076ffa881e2fb60d7e45b25641e1e7dd80580e59b3cce107";
  libraryHaskellDepends = [
    array base containers indexed-profunctors transformers
  ];
  description = "Optics as an abstract interface: core definitions";
  license = stdenv.lib.licenses.bsd3;
}
