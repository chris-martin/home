{
  description = "Haskell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in rec {
      ghc-9-6 = pkgs.haskell.packages.ghc96.ghcWithPackages (p: [
        p.digest
        p.unix
        p.zlib
      ]);

      hls = pkgs.haskell-language-server.override {
        supportedGhcVersions = [ "810" "90" "92" "94" "96" ];
      };

      cabal = pkgs.cabal-install;

      defaultPackage.x86_64-linux = pkgs.symlinkJoin {
        name = "haskell";
        paths = [ ghc-9-6 hls cabal ];
      };
    };
}
