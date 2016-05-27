{ stdenv, fetchgit, cmake, gmp, jsoncpp, cryptopp, llvm, amdappsdk,
  qt5, boost, leveldb, miniupnpc, curl, overrideCC, libmicrohttpd,
  gcc49, libjson_rpc_cpp, opencl-headers, ncurses, openssl,
  readline, snappy, scons, gperftools, libedit
}:

stdenv.mkDerivation rec {
  name = "ethereum-" + version;
  version = "1.2.4";

  # This list is based on the list of Arch dependencies at
  # http://www.ethdocs.org/en/latest/ethereum-clients/cpp-ethereum/building-from-source/linux.html
  # though I haven't confirmed whether these packages are all actually required.
  buildInputs = [
    cmake gmp jsoncpp cryptopp llvm amdappsdk qt5.qtbase boost leveldb
    miniupnpc curl libmicrohttpd libjson_rpc_cpp opencl-headers
    ncurses openssl readline snappy scons gperftools libedit
  ];

  src = fetchgit {
    url = "https://github.com/ethereum/webthree-umbrella.git";
    rev = "refs/tags/v${version}";
    sha256 = "1vgc6gnm257dzw73r06ahnw26lh4mvr868q9lilbg5vf0qrndxg8";
    fetchSubmodules = true;
  };

  cmakeFlags = stdenv.lib.flatten [

    # The GUI depends on qtwebengine, which we don't have packaged yet.
    "-DGUI=0"

    # ethashcl fails to compile for reasons unknown
    "-DETHASHCL=OFF"
  ];

  meta = {
    description = "Ethereum C++ implementation";
    homepage = "http://www.ethdocs.org/en/latest/ethereum-clients/cpp-ethereum/";
    license = with stdenv.licenses; [ mit gpl3 ];
  };
}
