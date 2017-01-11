{ stdenv, fetchurl, autoconf, automake, libtool, pkgconfig, czmq }:

let

version = "1.2.0";

in

stdenv.mkDerivation {
  name = "czmqpp-${version}";

  src = fetchurl {
    url = "https://github.com/zeromq/czmqpp/archive/v${version}.tar.gz";
    sha256 = "0aiyv0vpzi0d9gd5ap77zjkn6mkzi1bq71n26pqb1id7rz1q7naf";
  };

  buildInputs = [ autoconf automake libtool pkgconfig ];

  propagatedBuildInputs = [ czmq ];

  # https://github.com/zeromq/czmqpp/issues/42
  patches = [ ./socket.patch ];

  configurePhase = ''
    autoreconf -i
    ./configure --prefix=$out
  '';

  buildPhase = "make";

  installPhase = "make install";
}
