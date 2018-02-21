{ mkDerivation, base, microlens-platform, mtl, stdenv, yi-core
, yi-frontend-vty, yi-keymap-cua, yi-misc-modes, yi-mode-haskell
, yi-mode-javascript
}:
mkDerivation {
  pname = "yi-chris-martin";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: (builtins.substring 0 1 (baseNameOf path) != ".") && (baseNameOf path != "yi.nix")) ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base microlens-platform mtl yi-core yi-frontend-vty yi-keymap-cua
    yi-misc-modes yi-mode-haskell yi-mode-javascript
  ];
  license = stdenv.lib.licenses.unfree;
  hydraPlatforms = stdenv.lib.platforms.none;
}
