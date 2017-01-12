{ pkgs, config, unstable }:
let

pkgsWithOverrides = pkgs // overrides;

callEnv = path: import path {
  inherit config;
  pkgs = pkgsWithOverrides;
};

overrides = (with pkgs; rec {

  desktopEnv = callEnv ./envs/desktop.nix;
  serverEnv = callEnv ./envs/server.nix;

  # Python packages is its own separate bucket of overrides
  myPython27Packages = pkgs.python27Packages //
    (callPackage pkgs/python-packages.nix {
      python = python27;
      self = myPython27Packages;
    });

  myPython34Packages = pkgs.python34Packages //
    (unstable.callPackage pkgs/python-packages.nix {
      python = python34;
      self = myPython34Packages;
    });

  inherit (unstable) glide;

  go = go_1_7;

  inherit (unstable) sublime3;
  sublime = sublime3;

  pssh = callPackage ./pkgs/pssh {};

  ppl-address-book = callPackage ./pkgs/ppl-address-book {};

  # App engine init: https://github.com/NixOS/nixpkgs/pull/14237
  google-app-engine-sdk = callPackage ./pkgs/google-app-engine-sdk {};

  # Gore isn't backported to 16.03, and now it's gone from unstable.
  # - https://github.com/NixOS/nixpkgs/pull/15440
  # - https://github.com/NixOS/nixpkgs/commit/08575ee
  #gore = unstable.goPackages.gore;

  # Get is also now gone due to https://github.com/NixOS/nixpkgs/commit/08575ee
  # New PR at https://github.com/NixOS/nixpkgs/pull/16353
  # Using unstable because the new go infrastructure isn't in 16.03
  go-ethereum = unstable.callPackage ./pkgs/go-ethereum {};

  # StartupWMClass fix not backported to 16.03
  # https://github.com/NixOS/nixpkgs/pull/15685
  inherit (unstable) idea;

  # https://github.com/NixOS/nixpkgs/issues/18637
  # https://github.com/NixOS/nixpkgs/issues/18638
  secp256k1 = callPackage pkgs/secp256k1 {};

  # https://github.com/NixOS/nixpkgs/pull/15977
  serpent = callPackage pkgs/serpent {};

  # https://github.com/NixOS/nixpkgs/issues/18640
  tla-plus = callPackage pkgs/tla-plus {};

  # BigchainDB requires rethinkdb version higher than what's in 16.03
  inherit (unstable) rethinkdb;

  # https://github.com/NixOS/nixpkgs/issues/18640
  isabelle2011-1 = callPackage pkgs/isabelle2011-1 {
    inherit (pkgs) stdenv fetchurl nettools perl;
    inherit (pkgs.emacs24Packages) proofgeneral;
    polyml = pkgs.polyml_5_4;
  };

  libbitcoin = callPackage pkgs/libbitcoin/libbitcoin {};
  libbitcoin-client = callPackage pkgs/libbitcoin/client {};
  libbitcoin-explorer = callPackage pkgs/libbitcoin/explorer {};

  stellar-core = callPackage pkgs/stellar-core {};
  stellar-horizon = callPackage pkgs/stellar-horizon {};

  chain-core = callPackage pkgs/chain-core {};

  # Fall back to unstable for Haskell LTS releases that aren't in stable
  haskell = pkgs.haskell // {

    # https://github.com/NixOS/nixpkgs/issues/16629
    compiler = pkgs.haskell.compiler // { ghc801 = unstable.haskell.compiler.ghc801; };

    packages = unstable.haskell.packages // pkgs.haskell.packages;
  };

  latex = texlive.combine {
    inherit (texlive) scheme-medium mathabx-type1 latexmk;
  };

  # Workaround for Atom not working in 16.09
  # https://github.com/NixOS/nixpkgs/issues/16888#issuecomment-232351368
  atom = let v = "1.10.2"; in ( lib.overrideDerivation pkgs.atom (attrs: {
    name = "atom-${v}";
    src = fetchurl {
      url = "https://github.com/atom/atom/releases/download/v${v}/atom-amd64.deb";
      sha256 = "1pizmr5i4fnbxykrrqk7g837fj0plazgxrbgyqb9bns5nvwcrk6p";
      name = "atom-${v}.deb";
    };
  }));

  # Convenience aliases for nested packages

  inherit (pkgsWithOverrides.myPython34Packages) bigchaindb pyethereum;

});

# Ethereum work-in-progress
#
# I think we just need unstable here to get gcc49; we may be
# able to do with with an explicit dependency instead by passing
# an { stdenv = overrideCC stdenv gcc49; } override on 16.03
#(with unstable; rec {
#  ethereum = callPackage ./pkgs/ethereum {
#    llvm = llvm_38;
#  };
#});

in overrides
