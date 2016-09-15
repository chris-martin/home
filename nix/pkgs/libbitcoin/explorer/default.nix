{ stdenv, fetchurl, autoconf, automake, libtool, boost, pkgconfig, libbitcoin-client }:

let

version = "2.2.0";

in

stdenv.mkDerivation {
  name = "libbitcoin-explorer-${version}";

  src = fetchurl {
    url = "https://github.com/libbitcoin/libbitcoin-explorer/archive/v${version}.tar.gz";
    sha256 = "00123vw7rxk0ypdfzk0xwk8q55ll31000mkjqdzl915krsbkbfvp";
  };

  buildInputs = [ autoconf automake libtool pkgconfig ];

  propagatedBuildInputs = [ libbitcoin-client ];

  configurePhase = ''
    ./autogen.sh

    ./configure \
      --prefix=$out \
      --with-boost=${boost.dev} \
      --with-boost-libdir=${boost.out}/lib \
      --with-bash-completiondir=$out/share/bash-completion/completions
  '';

  buildPhase = "make";

  installPhase = "make install";
}
