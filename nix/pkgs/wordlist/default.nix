{ fetchurl, haskell, makeWrapper, stdenv, ... }:

let

  trezor-rev = "ec21884db9f3af236732121e7ccf97435b924915";

  data = fetchurl {
    url = "https://raw.githubusercontent.com/trezor/python-mnemonic/${trezor-rev}/mnemonic/wordlist/english.txt";
    sha256 = "1nnv4hxyv8pkxzw9yvb40f2yb47wkqckz3qdi3w4nyvjli9yspig";
  };

  exe = haskell.packages.lts-5_2.callPackage ./wordlist.nix { };

  wordlist = stdenv.mkDerivation {
    name = "wordlist";
    src = ./.;
    buildInputs = [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin
      ln -s ${exe}/bin/wordlist-exe $out/bin/wordlist
      wrapProgram $out/bin/wordlist --set WORD_LIST_PATH ${data}
    '';
    passthru = {
      inherit exe;
      env = exe.env;
    };
  };

in wordlist
