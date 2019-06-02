{ stdenv, fetchFromGitHub, pkgconfig, python, glib, libxml2, giflib, libjpeg, libtiff, uthash, libspiro, automake, flex, bison, autoconf, perl, libtool, git, gnulib }:

stdenv.mkDerivation rec {
  name = "fontforge-${version}";
  version = "20170731";

  buildInputs = [
    git
    libtool
    autoconf
    perl
    pkgconfig
    python
    glib
    libxml2
    giflib
    libjpeg
    libtiff
    uthash
    libspiro
    automake
    flex
    bison
    gnulib
  ];

  preConfigure = "./bootstrap";

  src = fetchFromGitHub {
    owner = "fontforge";
    repo = "fontforge";
    rev = "b9149c13e8f9464fc21473f1f676b36a2130775d";
    sha256 = "15k6x97383p8l40jvcivalhwgbbcdg5vciyjz6m9r0lrlnjqkv99";
  };

  meta = {
    homepage = https://fontforge.github.io/;
    description = "Create, edit and convert fonts in OpenType, TrueType, UFO, CID-keyed, Multiple Master, and many other formats.";
    license = stdenv.lib.licenses.gpl3;
  };
}
