{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation rec {
  name = "serpent";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "serpent";
    rev = "51ee60857fe53c871fa916ef66fc1b4255bb9433";
    sha256 = "1bns9wgn5i1ahj19qx7v1wwdy8ca3q3pigxwznm5nywsw7s7lqxs";
  };

  installPhase = ''
    mkdir -p $out/bin
    mv serpent $out/bin
  '';
}
