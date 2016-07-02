{ haskell, stdenv, ... }:

let

haskFn = { mkDerivation, base, optparse-applicative, random, stdenv, text }:
mkDerivation {
  pname = "choose";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: baseNameOf path != "dist") ./.;
  isExecutable = true;
  executableHaskellDepends = [ base optparse-applicative random text  ];
  license = stdenv.lib.licenses.asl20;
};

hask = haskell.packages.lts-5_9.callPackage haskFn { };

choose = stdenv.mkDerivation {
  name = "choose";
  src = builtins.filterSource (path: type: false) ./.;
  installPhase = ''
    mkdir -p $out/bin
    cp ${hask}/bin/choose $out/bin
  '';
  passthru = { env = hask.env; };
};

in choose
