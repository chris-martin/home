{ mkDerivation, base, fetchgit, GLUT, stdenv }:
mkDerivation {
  pname = "Shu-thing";
  version = "1.1.3";
  src = fetchgit {
    url = "https://github.com/typeclasses/shu-thing.git";
    sha256 = "0pzlwhq89l9najy8f2y4sq19cqy9z7d8bjd1vrn25cymg3v53ksq";
    rev = "3564cb49fec63d4173d190f4f3bf0fe7ed7e07b3";
    fetchSubmodules = true;
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base GLUT ];
  homepage = "http://www.geocities.jp/takascience/index_en.html";
  description = "A vector shooter game";
  license = stdenv.lib.licenses.bsd3;
}
