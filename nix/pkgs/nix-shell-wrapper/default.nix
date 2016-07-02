{ haskell, stdenv, makeWrapper, ... }:

let

haskFn = { mkDerivation, base, directory, path, posix-escape, process, stdenv }:
mkDerivation {
  pname = "nix-shell-wrapper";
  version = "0.1.0.0";
  src = builtins.filterSource (path: type: baseNameOf path != "dist") ./.;
  isExecutable = true;
  executableHaskellDepends = [ base directory path posix-escape process ];
  license = stdenv.lib.licenses.asl20;
};

hask = haskell.packages.lts-5_9.callPackage haskFn { };

nix-shell-wrappers = stdenv.mkDerivation {
  name = "nix-shell-wrapper";
  src = builtins.filterSource (path: type: false) ./.;
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin

    cp ${hask}/bin/haskell $out/bin/nix-shell.ghc-mod
    wrapProgram $out/bin/nix-shell.ghc-mod \
      --set NIX_SHELL_WRAPPER_COMMAND ghc-mod

    cp ${hask}/bin/haskell $out/bin/nix-shell.ghc-modi
    wrapProgram $out/bin/nix-shell.ghc-modi \
      --set NIX_SHELL_WRAPPER_COMMAND ghc-modi
  '';
  passthru = { env = hask.env; };
};

in nix-shell-wrappers
