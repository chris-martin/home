{ fetchzip, makeWrapper, stdenv, jre,

  # options
  javaMain, execName, ... }:

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
    echo -e "${jre}/bin/java ${javaMain} \"\$@\"" > $out/bin/${execName}
    chmod +x $out/bin/${execName}
    wrapProgram $out/bin/${execName} --set CLASSPATH $src
  '';
}
