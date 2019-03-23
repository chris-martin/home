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
    rev = "aee6558c7f9312b20cc1d12414ddc298d20f8c66";
    sha256 = "0pv91i5j6paivwiacbd36hix6c2xnx0d4g2pahcz8mmh1wp6dpdf";
  };

  haskellAndPackages = haskell.packages.ghc864.ghcWithPackages (p: [
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
