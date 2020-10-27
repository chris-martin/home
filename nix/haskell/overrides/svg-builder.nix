{ mkDerivation, base, blaze-builder, bytestring, fetchgit, hashable
, stdenv, text, unordered-containers
}:
mkDerivation {
  pname = "svg-builder";
  version = "0.1.1";
  src = fetchgit {
    url = "https://github.com/chris-martin/svg-builder.git";
    sha256 = "01s4rcfvjkwqdv3fvqq9cikwwalxgik93rchhk8f5xziyz5v9zpm";
    rev = "921fa1f77f88d1d77b3d22a2157004f477ee27eb";
    fetchSubmodules = true;
  };
  libraryHaskellDepends = [
    base blaze-builder bytestring hashable text unordered-containers
  ];
  homepage = "https://github.com/diagrams/svg-builder.git";
  description = "DSL for building SVG";
  license = stdenv.lib.licenses.bsd3;
}
