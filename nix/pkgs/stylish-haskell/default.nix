{ writeShellScriptBin, haskell, haskellPackages }:

let
  stylish-haskell =
    haskell.lib.justStaticExecutables haskellPackages.stylish-haskell;

in
  writeShellScriptBin "stylish-haskell" ''
    cd "$1"
    find . -name "*.hs" -not -path '*/\.*' \
      -exec ${stylish-haskell}/bin/stylish-haskell -i "{}" \;
  ''
