{ stdenv, fetchzip, jre, jdk }:

stdenv.mkDerivation {
  name = "jetrix-0.2.3";

  src = fetchzip {
    url = "mirror://sourceforge/project/jetrix/Jetrix%20TetriNET%20Server/0.2.3/jetrix-0.2.3.zip";
    sha256 = "03vhvlf132x9mwmi6g6xp8h6nzclg2f1rdqkcsadhllg46xpafpv";
  };

  installPhase = ''
    mkdir -p "$out/bin" "$out/lib"
    cp -r lang "$out"
    cp "${./channels.xml}" "$out/channels.xml"
    cp "${./server.xml}" "$out/server.xml"
    cp lib/*.jar lib/*.war "$out/lib"

    for x in lib/*.pack; do
      ${jdk}/bin/unpack200 "$x" "$out/lib/$(basename "$x" .pack).jar"
    done

    echo "#!${stdenv.shell}" > $out/bin/jetrix
    echo "(cd "$out"; \"${jre}/bin/java\" -jar lib/jetrix-launcher-0.2.3.jar)" >> "$out/bin/jetrix"
    chmod +x "$out/bin/jetrix"
  '';
}
