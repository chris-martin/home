{ fetchzip, makeWrapper, stdenv, jre, swt, bash, ... }:

# http://research.microsoft.com/en-us/um/people/lamport/tla/tools.html
stdenv.mkDerivation rec {
  name = "tla-plus";

  src = fetchzip {
    url = "https://tla.msr-inria.inria.fr/tlatoolbox/dist/tla.zip";
    sha256 = "1n4v2pnlbih8hgmchwb21wy9cwv59gb3jv0rj427jal3nyh2ay3b";
  };

  buildInputs = [ makeWrapper ];

  phases = [ "installPhase" ];

  installPhase = ''

    mkdir -pv $out/bin

    java=${jre}/bin/java

    mkbin () {
      bin=$out/bin/$1
      echo -e "$java $2 \"\$@\"" > $bin
      chmod +x $bin
      wrapProgram $bin --set CLASSPATH $src
    }

    mkbin tlc     tlc2.TLC
    mkbin sany    tla2sany.SANY
    mkbin pluscal pcal.trans
    mkbin tlatex  tla2tex.TLA
  '';
}
