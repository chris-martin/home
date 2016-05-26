/* This uses mkDerivation instead of buildPythonPackage because the
   App Engine SDK isn't packaged for `distutils/setuptools` and doesn't
   have a setup.py file. */

{ unzip, makeWrapper, fetchurl, stdenv, python27, python27Full }:

stdenv.mkDerivation rec {
  name = "google-app-engine-sdk-${version}";
  version = "1.9.35";
  buildInputs = [ unzip makeWrapper ];

  src = fetchurl {
    url = "https://storage.googleapis.com/appengine-sdks/featured/google_appengine_${version}.zip";
    sha256 = "19qxkxvb7nxs64mdjlxdhzbg16n5qwp8v229lvkpw9w0i8hghpj0";
  };

  unpackPhase = "unzip $src";

  installPhase = ''
    mkdir -p $out/lib/${python27.libPrefix}
    mv google_appengine $out/lib/${python27.libPrefix}/site-packages
    mkdir -p $out/bin
    # Create a wrapper script for each of the python scripts that
    # the SDK  provides. For example, `dev_appserver.py` becomes
    # `google-app-engine-python-dev-appserver`.
    for f in $(find $out/lib/${python27.libPrefix}/site-packages -maxdepth 1 -type f -regex ".*/[a-z][^/]*.py"); do
      makeWrapper $f \
        $out/bin/google-app-engine-python-$(basename $f | sed s/_/-/ | sed s/\.py//) \
        --prefix PATH : ${python27Full}/bin
    done
  '';

  meta = {
    description = "A sandbox that emulates Google App Engine services";
    homepage = "https://cloud.google.com/appengine/docs/python/";
    license = stdenv.licenses.asl20;
  };
}
