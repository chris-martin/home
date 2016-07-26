# The TLA+ Proof System (TLAPS) mechanically checks TLA+ proofs.

{ fetchurl, makeWrapper, stdenv, ocaml, wget, gawk, ... }:

let

  version = "1.4.3";

  src = fetchurl {
    url = "https://tla.msr-inria.inria.fr/tlaps/dist/current/tlaps-${version}.tar.gz";
    sha256 = "1w5z3ns5xxmhmp8r4x2kjmy3clqam935gmvx82imyxrr1bamx6gf";
  };

  isabelle = stdenv.mkDerivation {
    name = "tla-ps-${version}-isabelle";
    src = src;
    buildInputs = [ ocaml ];
    configurePhase = ''
      cd zenon
      ./configure --prefix $out
    '';
  };

  zenon = stdenv.mkDerivation {
    name = "tla-ps-${version}-zenon";
    src = src;
    buildInputs = [ ocaml ];
    configurePhase = ''
      cd zenon
      ./configure --prefix $out
    '';
  };

  path = [
    "${isabelle}/bin"
    "${zenon}/bin"
  ];

in

stdenv.mkDerivation {
  name = "tla-ps-${version}";
  buildInputs = [ makeWrapper wget ocaml gawk ];
  src = src;

  configurePhase = ''
    cd tlapm
    ./configure --prefix $out
  '';

  postInstall = ''
    wrapProgram $out/bin/tlapm \
      --prefix PATH : "${builtins.concatStringsSep ":" path}"
  '';
}
