{ mkDerivation, base, containers, directory, fetchgit, filepath
, haskell-src-exts, optparse-applicative, pipes, stdenv, text
}:
mkDerivation {
  pname = "hs-nix-modules";
  version = "0";
  src = fetchgit {
    url = "https://github.com/typeclasses/hs-nix-modules.git";
    sha256 = "0vq1b6nd1rds3iv7xm8891q2z4sc8hxwhwvwchf96bzqh6zi6ksx";
    rev = "5c7cb693c3121b41d46aa28f16209d0b4be1e4f7";
    fetchSubmodules = true;
  };
  postUnpack = "sourceRoot+=/hs-nix-modules; echo source root reset to $sourceRoot";
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base containers directory filepath haskell-src-exts
    optparse-applicative pipes text
  ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
