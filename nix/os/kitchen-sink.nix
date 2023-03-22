{ pkgs, ... }:
let
  unstable = pkgs.nixpkgs-unstable;
  haskellStuff =
    let
      pkgs = unstable;
      compilers =
        [
          # (pkgs.haskell.packages.ghc94.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.sdl2 p.unix p.zlib ]))
          (pkgs.haskell.packages.ghc92.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.sdl2 p.unix p.zlib ]))
          # (pkgs.haskell.packages.ghc90.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
          (pkgs.haskell.packages.ghc8107.ghcWithPackages (p: [ p.digest p.postgresql-libpq p.unix p.zlib ]))
        ];

      hls = pkgs.haskell-language-server.override {
        supportedGhcVersions = [/*"810" "90"*/ "92" "94"];
      };
    in
      compilers ++ [
        hls
        pkgs.cabal-install
        unstable.cabal2nix
        #pkgs.ghcid
        #pkgs.hindent
        #pkgs.hlint
        #pkgs.hpack
        #pkgs.stack
      ];
in
{
  environment.systemPackages = haskellStuff ++ [

  ];
}
