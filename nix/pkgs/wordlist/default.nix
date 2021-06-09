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
    rev = "82f79e811a4d54ec821bd4398cfc2cbefa6099ad";
    sha256 = "03hhldr149hff9czd2ri52q9llgkxdy70fvfphplqbbd81bqa8wk";
  };

  haskellAndPackages = haskell.packages.ghc884.ghcWithPackages (p: [
    p.base
    p.containers
    p.MonadRandom
    p.optparse-applicative
    p.text
    p.vector
  ]);

in stdenv.mkDerivation {
  name = "wordlist";
  inherit src;
  buildInputs = [ makeWrapper haskellAndPackages ];
  installPhase = ''
    cd wordlist
    runhaskell Setup.hs configure
    runhaskell Setup.hs build
    mkdir -p $out/bin
    cp ./dist/build/wordlist/wordlist $out/bin
    wrapProgram $out/bin/wordlist --set WORD_LIST_PATH ${data}
  '';
}
