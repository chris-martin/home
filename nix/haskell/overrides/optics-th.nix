{ mkDerivation, base, containers, mtl, optics-core, stdenv, tagged
, template-haskell, th-abstraction, transformers
}:
mkDerivation {
  pname = "optics-th";
  version = "0.3.0.2";
  sha256 = "80f0cbb1cda044631ef421a0112e2d9a9868c22d95e845d97902d0fbf822b1d7";
  libraryHaskellDepends = [
    base containers mtl optics-core template-haskell th-abstraction
    transformers
  ];
  testHaskellDepends = [ base optics-core tagged ];
  description = "Optics construction using TemplateHaskell";
  license = stdenv.lib.licenses.bsd3;
}
