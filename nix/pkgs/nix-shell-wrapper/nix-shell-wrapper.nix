{ mkDerivation, base, directory, path, posix-escape, process, stdenv }:
mkDerivation {
  pname = "nix-shell-wrapper";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: baseNameOf path != "dist") ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base directory path posix-escape process ];
  executableHaskellDepends = [ base ];
  license = stdenv.lib.licenses.asl20;
}
