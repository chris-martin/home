{ haskell, haskellPackages }:

haskell.lib.justStaticExecutables
  (haskellPackages.override {
    overrides = haskellPackagesNew: haskellPackagesOld: rec {
      ede = haskellPackagesNew.callPackage ./ede.nix {};
    };
  }).ede
