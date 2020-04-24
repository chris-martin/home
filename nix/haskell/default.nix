{ haskell, runCommand, symlinkJoin, lib, linkFarm, callPackage }:

let

  compilerVersion = "ghc883";
  packages = import ./packages.nix;
  haskellPackages = haskell.packages.${compilerVersion}.override { overrides = import ./overrides.nix; };

in

{
  ghc = haskellPackages.ghcWithPackages (p: map (name: p.${name}) packages);
  ghcid = haskellPackages.ghcid;
  ghcide = (import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/fd42f62613d491565c1676821148c008b2011584") {})."ghcide-${compilerVersion}";
}
