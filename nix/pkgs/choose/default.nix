{ haskell, stdenv, ... }:

let

  exe = haskell.packages.lts-5_9.callPackage ./choose.nix { };

  choose = stdenv.mkDerivation {
    name = "choose";
    src = builtins.filterSource (path: type: false) ./.;
    installPhase = ''
      mkdir -p $out/bin
      cp ${exe}/bin/choose-exe $out/bin/choose
    '';
    passthru = {
      inherit exe;
      env = exe.env;
    };
  };

in choose
