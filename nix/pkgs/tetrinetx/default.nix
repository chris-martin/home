{ stdenv, fetchurl, adns }:

stdenv.mkDerivation {
  name = "tetrinetx-1.13.16+qirc-1.40c";

  src = fetchurl {
    url = "mirror://sourceforge/project/tetrinetx/tetrinetx/1.40c/tetrinetx-1.13.16+qirc-1.40c.tar.gz";
    sha256 = "1m0m1paaqnki38q2d5cr6n0fb36agdmw7ayq93k1634mr2h10wib";
  };

  installPhase = ''
    mkdir -p "$out/bin"
    gcc -O2 -fno-strength-reduce -Wall src/main.c -o $out/bin/tetrinetx -ladns
  '';

  buildInputs = [ adns ];

}
