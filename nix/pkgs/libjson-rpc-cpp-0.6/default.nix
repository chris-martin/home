{ stdenv, fetchFromGitHub, cmake, curl, libmicrohttpd, argtable, doxygen,
  catch, jsoncpp }:

with {
  basename = "libjson-rpc-cpp";
  version = "0.6.0";
};

stdenv.mkDerivation {
  name = "${basename}-${version}";

  src = fetchFromGitHub {
    owner = "cinemast";
    repo = basename;
    rev = "v${version}";
    sha256 = "00fxxisg89zgg1wq047n8r8ws48jx35x3s6bbym4kg7dkxv9vv9f";
  };

  buildInputs = [ cmake curl libmicrohttpd argtable doxygen catch jsoncpp ];

  cmakeFlags = stdenv.lib.flatten [
    "-DCOMPILE_STUBGEN=0"
    "-DJSONCPP_INCLUDE_PREFIX=json"
  ];

  meta = {
    description = "C++ framework for json-rpc (json remote procedure call)";
    homepage = https://github.com/cinemast/libjson-rpc-cpp;
    license = stdenv.lib.licenses.mit;
    platforms = stdenv.lib.platforms.linux;
  };
}
