{ stdenv, fetchurl, autoreconfHook, gnutls, zlib, glib, pkgconfig }:

stdenv.mkDerivation rec {
  name = "kbtin-${version}";
  version = "1.0.17";

  src = fetchurl {
    url = "https://github.com/kilobyte/kbtin/archive/v${version}.tar.gz";
    sha256 = "1zdxix0v1zb62nlyhv0l1pibxn9canih1k08ab6wqbpxkv2m0hsz";
  };

  buildInputs = [ gnutls zlib glib pkgconfig ];

  nativeBuildInputs = [ autoreconfHook ];

  patchPhase = "touch config.rpath";

  buildPhase = "make";

  installPhase = ''
    env HOME="$PWD" make bin
    mkdir -p $out/bin
    cp bin/{ansi2html,ansi2txt,KBtin,pipetty,ttyrec2ansi} $out/bin
  '';
}
