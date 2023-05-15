{
  description = "Haskell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let pkgs = import nixpkgs { system = "x86_64-linux"; };
    in rec {
      ghc-9-0 = pkgs.haskell.packages.ghc90.ghcWithPackages
        (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]);
      ghc-9-2 = pkgs.haskell.packages.ghc92.ghcWithPackages
        (p: [ p.digest p.postgresql-libpq p.sdl2 p.unix p.zlib ]);
      ghc-9-4 = pkgs.haskell.packages.ghc94.ghcWithPackages (p: [
        p.digest
        p.postgresql-libpq
        # p.relude
        p.sdl2
        p.unix
        p.vulkan
        p.vulkan-utils
        p.zlib
      ]);
      ghc-9-6 = pkgs.haskell.packages.ghc96.ghcWithPackages (p: [
        p.digest
        # p.relude
        p.unix
        p.zlib
      ]);

      hls = pkgs.haskell-language-server.override {
        supportedGhcVersions = [ "90" "92" "94" ];
      };

      cabal = pkgs.cabal-install;

      defaultPackage.x86_64-linux = pkgs.symlinkJoin {
        name = "haskell";
        paths = [ ghc-9-4 ghc-9-6 ghc-9-2 ghc-9-0 hls cabal ];
      };
    };
}
