{ fetchurl, fetchFromGitHub, haskell, makeWrapper, stdenv, ... }:

let

  trezor-rev = "ec21884db9f3af236732121e7ccf97435b924915";

  data = fetchurl {
    url = "https://raw.githubusercontent.com/trezor/python-mnemonic/" +
          trezor-rev + "/mnemonic/wordlist/english.txt";
    sha256 = "1nnv4hxyv8pkxzw9yvb40f2yb47wkqckz3qdi3w4nyvjli9yspig";
  };

  src = fetchFromGitHub {
    owner = "chris-martin";
    repo = "wordlist";
    rev = "8f52db02096e37be56fb8f7bc62ed081cb72708b";
    sha256 = "1mchlw9sh7qbfh1nsiylkxlv3n4qshnv9ljfdinszfcyr861x0la";
  };

  haskellAndPackages = haskell.packages.ghc802.ghcWithPackages (p: with p; [
    base containers MonadRandom optparse-applicative stdenv text
    hpack
  ]);

in stdenv.mkDerivation {
  name = "wordlist";
  inherit src;
  buildInputs = [ makeWrapper haskellAndPackages ];
  installPhase = ''
    cd wordlist
    hpack
    runhaskell Setup.hs configure
    runhaskell Setup.hs build
    mkdir -p $out/bin
    cp ./dist/build/wordlist/wordlist $out/bin
    wrapProgram $out/bin/wordlist --set WORD_LIST_PATH ${data}
  '';
}
