{ haskell, haskellPackages }:

haskell.lib.justStaticExecutables
  (haskellPackages.callPackage ./text-replace.nix { })
