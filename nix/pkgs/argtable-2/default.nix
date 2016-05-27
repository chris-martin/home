{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "argtable-${version}";
  version = "2.13";

  src = fetchurl {
    url = "http://prdownloads.sourceforge.net/argtable/argtable2-13.tar.gz";
    sha256 = "1gyxf4bh9jp5gb3l6g5qy90zzcf3vcpk0irgwbv1lc6mrskyhxwg";
  };

  meta = {
    homepage = http://argtable.sourceforge.net/;
    description = "An ANSI C library for parsing GNU style command line options with a minimum of fuss";
    license = stdenv.lib.licenses.lgpl;
  };

  NIX_CFLAGS_COMPILE = [ "-fPIC" ];
}
