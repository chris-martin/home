{ stdenv, fetchurl, autoconf, automake, libtool, boost, pkgconfig, libsodium, czmqpp, libbitcoin }:

let

version = "2.2.0";

in

stdenv.mkDerivation {
  name = "libbitcoin-client-${version}";

  src = fetchurl {
    url = "https://github.com/libbitcoin/libbitcoin-client/archive/v${version}.tar.gz";
    sha256 = "1g79hl6jmf5dam7vq19h4dgdj7gcn19fa7q78vn573mg2rdyal53";
  };

  buildInputs = [ autoconf automake libtool pkgconfig ];

  propagatedBuildInputs = [ libsodium czmqpp libbitcoin ];

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
