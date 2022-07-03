{ haskell, runCommand, symlinkJoin, lib, linkFarm, callPackage }:

let

  compilerVersion = "ghc902";
  packages = import ./packages.nix;
  haskellPackages = haskell.packages.${compilerVersion}.override { overrides = import ./overrides.nix haskell; };

in

{
  ghc = haskellPackages.ghcWithPackages (p: map (name: p.${name}) packages);
  ghcid = haskellPackages.ghcid;
}
