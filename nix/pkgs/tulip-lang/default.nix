{ stdenv, fetchFromGitHub, clang }:

let
  version = "2016-06-12";
in

stdenv.mkDerivation {

  name = "tulip-lang-${version}";

  src = fetchFromGitHub {
    name = "tulip-${version}";
    owner = "tulip-lang";
    repo = "tulip";
    rev = "2bbf64290614f35cba24ec905fcf3f34c9935c2c";
    sha256 = "1a5fxcch316qlnpnfgavfngj05x9vrcv7862db3p4kd8pk8wiic6";
  };

  buildInputs = [ clang ];

  installPhase = ''
    mkdir -p $out
    cp -rv build $out/bin
  '';

}
