{ haskell, haskellPackages }:

let
  my-haskellPackages = haskellPackages.override {
    overrides = haskellPackagesNew: haskellPackagesOld: rec {

      my-xmonad = haskellPackagesNew.callPackage ./my-xmonad.nix { };

    };
  };

in
  haskell.lib.justStaticExecutables my-haskellPackages.my-xmonad
