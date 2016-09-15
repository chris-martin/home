{ fetchurl, haskell, makeWrapper, stdenv, ... }:

let

trezor-rev = "ec21884db9f3af236732121e7ccf97435b924915";

data = fetchurl {
  url = "https://raw.githubusercontent.com/trezor/python-mnemonic/" +
        trezor-rev + "/mnemonic/wordlist/english.txt";
  sha256 = "1nnv4hxyv8pkxzw9yvb40f2yb47wkqckz3qdi3w4nyvjli9yspig";
};

haskFn = { mkDerivation, base, containers, optparse-applicative,
           random, stdenv, text }:
mkDerivation {
  pname = "wordlist";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: baseNameOf path != "dist") ./.;
  isExecutable = true;
  executableHaskellDepends = [ containers optparse-applicative random text ];
  license = stdenv.lib.licenses.asl20;
};

hask = haskell.packages.lts-6_7.callPackage haskFn { };

wordlist = stdenv.mkDerivation {
  name = "wordlist";
  src = builtins.filterSource (path: type: false) ./.;
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp ${hask}/bin/wordlist $out/bin
    wrapProgram $out/bin/wordlist --set WORD_LIST_PATH ${data}
  '';
  passthru = { env = hask.env; };
};

in wordlist
