{ stdenv, fetchurl, autoconf, automake, libtool, boost, pkgconfig, libsodium, czmqpp, secp256k1 }:

let

version = "2.11.0";

in

stdenv.mkDerivation {
  name = "libbitcoin-${version}";

  src = fetchurl {
    url = "https://github.com/libbitcoin/libbitcoin/archive/v${version}.tar.gz";
    sha256 = "1lpdjm13kgs4fbp579bwfvws8yf9mnr5dw3ph8zxg2gf110h85sy";
  };

  buildInputs = [ autoconf automake libtool pkgconfig ];

  propagatedBuildInputs = [ secp256k1 ];

  configurePhase = ''
    ./autogen.sh

    ./configure \
      --prefix=$out \
      --with-boost=${boost.dev} \
      --with-boost-libdir=${boost.out}/lib
  '';

  buildPhase = "make";

  installPhase = "make install";
}
