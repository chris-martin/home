{ haskell, stdenv, makeWrapper, ... }:

let

  exe = haskell.packages.lts-5_9.callPackage ./nix-shell-wrapper.nix { };

  nix-shell-wrappers = stdenv.mkDerivation {
    name = "nix-shell-wrapper";
    src = builtins.filterSource (path: type: false) ./.;
    buildInputs = [ makeWrapper ];
    installPhase = ''
      mkdir -p $out/bin

      cp ${exe}/bin/haskell-exe $out/bin/nix-shell.ghc-mod
      wrapProgram $out/bin/nix-shell.ghc-mod \
        --set NIX_SHELL_WRAPPER_COMMAND ghc-mod

      cp ${exe}/bin/haskell-exe $out/bin/nix-shell.ghc-modi
      wrapProgram $out/bin/nix-shell.ghc-modi \
        --set NIX_SHELL_WRAPPER_COMMAND ghc-modi
    '';
    passthru = {
      inherit exe;
      env = exe.env;
    };
  };

in nix-shell-wrappers
