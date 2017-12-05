{ fetchFromGitHub, fetchurl, stdenv, python2, makeWrapper
, flac, opusTools, vorbis-tools, lame }:

let
  pname = "flac2all";
  version = "3";

  testFile = fetchurl {
    name = "test.flac";
    url = "https://upload.wikimedia.org/wikipedia/commons/5/53/Mode_de_la.flac";
    sha256 = "1nsg4ln6zlr6qkb3kwzf41xaqgwfhx76snlqbhls5c7ghpafnmjh";
  };

in
  stdenv.mkDerivation {
    name = "${pname}-${version}";

    src = fetchFromGitHub {
      owner = "ZivaVatra";
      repo = "flac2all";
      rev = "55fd955adc178dd110773190a5d3ffc4420024f2";
      sha256 = "087ssx6b41v3pp6cml8bljfxicchg4q9aa8f9fqjd6g2283h85n1";
    };

    phases = [ "unpackPhase" "checkPhase" "installPhase" ];

    buildInputs = [ makeWrapper ];

    path = "${python2}/bin:${flac}/bin:${opusTools}/bin:${vorbis-tools}/bin:${lame}/bin";

    doCheck = true;

    checkPhase = ''
      cp $src/stable/*.py .
      mkdir testinput
      cp "${testFile}" testinput
      env PATH="$PATH:$path" python2 run_tests.py
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp $src/stable/flac2all.py $out/bin/flac2all
      wrapProgram $out/bin/flac2all --prefix PATH ":" "$path"
    '';

    meta = {
      homepage = https://github.com/ZivaVatra/flac2all;
      license = stdenv.lib.licenses.gpl2;
      description = "Converts FLAC files to other audio formats.";

      longDescription = ''
        Flac2All is a multi-threaded script that will convert your collection
        of FLAC files into either Ogg Vorbis, MP3 (with the Lame encoder), or
        FLAC, complete with any tags that the source file had. Utility for
        people with with large FLAC collections who also want a lossy version
        for portable media players.
      '';
    };
  }

