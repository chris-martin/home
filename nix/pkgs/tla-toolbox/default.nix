{ fetchzip, makeWrapper, stdenv, jre, swt, gtk, libXtst, glib, ... }:

stdenv.mkDerivation rec {
  name = "tla-toolbox";
  version = "1.5.2";
  arch = "x86_64";

  src = fetchzip {
    url = "https://tla.msr-inria.inria.fr/tlatoolbox/products/" +
          "TLAToolbox-${version}-linux.gtk.${arch}.zip";
    sha256 = "1k5bxn60qrqaxg1ihdqfyzgzgpan0n547574i31j45l5nxq8kf6n";
  };

  buildInputs = [ makeWrapper ];

  phases = [ "installPhase" ];

  installPhase = ''

    mkdir -pv $out/bin
    echo $out

    cp -rv $src $out/toolbox

    chmod +w $out/toolbox/toolbox

    patchelf \
      --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      $out/toolbox/toolbox

    echo "cd $(echo $out/toolbox); ./toolbox -data ~/.tla-toolbox \"$@\"" \
      > $out/bin/tla-toolbox

    chmod +x $out/bin/tla-toolbox

    wrapProgram $out/bin/tla-toolbox \
      --prefix PATH : "${builtins.concatStringsSep ":" path}"
      --prefix LD_LIBRARY_PATH : "${builtins.concatStringsSep ":" ld-library-path}"
  '';

  path = [
    "${jre}/bin"
  ];

  ld-library-path = [
    "${swt}/lib"
    "${gtk}/lib"
    "${libXtst}/lib"
    "${glib}/lib"
  ];
}
