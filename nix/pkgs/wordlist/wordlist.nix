{ mkDerivation, base, containers, optparse-applicative, random
, stdenv, text
}:
mkDerivation {
  pname = "wordlist";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: baseNameOf path != "dist") ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers optparse-applicative random text
  ];
  executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.asl20;
}
