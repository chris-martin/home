{ stdenv, buildGoPackage, fetchgit, makeWrapper, pkgconfig, qtbase, qtdeclarative, qtwebengine }:

buildGoPackage rec {
  pname = "gopherclient";
  version = "2020-01-03";
  rev = "475bab0004c93577a52944a95eaf0f3144699d68";

  goPackagePath = "github.com/prologic/gopherclient";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/prologic/gopherclient";
    sha256 = "1fhjf78c10pa2rfwmf5jnrxbm1g94r2bjh0q64c92x5msc3icni8";
  };

  nativeBuildInputs = [ makeWrapper pkgconfig ];

  buildInputs = [ qtbase qtdeclarative qtwebengine ];

  preBuild = ''
    # Generate gopherclient resources with genqrc.
    ln -s ${goPackagePath}/vendor/gopkg.in go/src/
    GOBIN="$(pwd)" go install -v gopkg.in/qml.v1/cmd/genqrc
    PATH="$(pwd):$PATH" go generate ${goPackagePath}
  '';

  # NIX_CFLAGS_COMPILE = [
  #   # go-qml needs private Qt headers.
  #   "-I${qtbase.dev}/include/QtCore/${qtbase.version}"
  # ];

  postInstall = ''
    # https://github.com/prologic/gopherclient/#usage
    wrapProgram $bin/bin/gopherclient --prefix GODEBUG , cgocheck=0
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/prologic/gopherclient;
    description = "Gopher Qt GUI client";
    license = licenses.mit;
    maintainers = with maintainers; [ orivej ];
    platforms = platforms.linux;
  };
}
