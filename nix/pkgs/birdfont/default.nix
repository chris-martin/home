{ stdenv, fetchurl, python3, vala, gnome3 }:

stdenv.mkDerivation rec {
  name = "birdfont-${version}";
  version = "2.24.0";

  nativeBuildInputs = [ vala gnome3.libgee ];

  src = fetchurl {
    url = "https://birdfont.org/releases/birdfont-${version}.tar.xz";
    sha256 = "1bmaabwpbi93ja6vcjirzfglsv460vsh5g8mkgd82vfsz3swikmm";
  };

  patchPhase = ''
    sed -i 's,#!/usr/bin/python3,#!${python3}/bin/python3,' configure
  '';

  meta = {
    homepage = https://birdfont.org/;
    description = "A free font editor which lets you create vector graphics and export TTF, OTF, EOT and SVG fonts.";
    license = stdenv.lib.licenses.gpl3;
  };
}
