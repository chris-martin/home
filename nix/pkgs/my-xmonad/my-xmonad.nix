{ mkDerivation, base, stdenv, xmonad, xmonad-contrib, xmonad-extras
}:
mkDerivation {
  pname = "my-xmonad";
  version = "0.0.0";
  src = builtins.filterSource
    (path: type: builtins.substring 0 1 (baseNameOf path) != ".")
    ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base xmonad xmonad-contrib xmonad-extras
  ];
  license = stdenv.lib.licenses.unfree;
  hydraPlatforms = stdenv.lib.platforms.none;
}
