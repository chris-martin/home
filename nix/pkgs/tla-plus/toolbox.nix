{ lib, fetchzip, makeWrapper, stdenv, jre, swt, gtk, libXtst, glib, ... }:

let

  version = "1.5.2";

  arch = "x86_64";

in stdenv.mkDerivation {

  name = "tla-toolbox-${version}";

  meta = {

    homepage = "http://research.microsoft.com/en-us/um/people/lamport/tla/toolbox.html";

    description = "IDE for the TLA+ tools";

    longDescription = ''
      Integrated development environment for the TLA+ tools, based on Eclipse. You can use it
      to create and edit your specs, run the PlusCal translator, view the pretty-printed
      versions of your modules, run the TLC model checker, and run TLAPS, the TLA+ proof system.
    '';

    # http://research.microsoft.com/en-us/um/people/lamport/tla/license.html
    license = with lib.licenses; [ mit ];

  };

  src = fetchzip {
    url = "https://tla.msr-inria.inria.fr/tlatoolbox/products/TLAToolbox-${version}-linux.gtk.${arch}.zip";
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
      --prefix PATH : "${jre}/bin" \
      --prefix LD_LIBRARY_PATH : "${swt}/lib:${gtk}/lib:${libXtst}/lib:${glib}/lib"
  '';

}
