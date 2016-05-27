{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "libscrypt-${version}";
  version = "1.21";
  src = fetchFromGitHub {
    owner = "technion";
    repo = "libscrypt";
    rev = "v${version}";
    sha256 = "1d76ys6cp7fi4ng1w3mz2l0p9dbr7ljbk33dcywyimzjz8bahdng";
  };
  preConfigure = "export PREFIX=$out";
}
