{ pkgs, config, unstable, master }:
let

pkgsWithOverrides = pkgs // overrides;

callEnv = path: import path {
  inherit config;
  pkgs = pkgsWithOverrides;
};

overrides = (with pkgs; rec {

  desktopEnv = callEnv ./desktopEnv.nix;

  inherit (unstable) stylish-haskell stack jetbrains;

  my-emacs = (import "${config.home}/emacs/emacs.nix") unstable.pkgs;

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

  ppl-address-book = callPackage ./pkgs/ppl-address-book {};

  # App engine init: https://github.com/NixOS/nixpkgs/pull/14237
  google-app-engine-sdk = callPackage ./pkgs/google-app-engine-sdk {};

  # Gore isn't backported to 16.03, and now it's gone from unstable.
  # - https://github.com/NixOS/nixpkgs/pull/15440
  # - https://github.com/NixOS/nixpkgs/commit/08575ee
  #gore = unstable.goPackages.gore;

  # https://github.com/NixOS/nixpkgs/issues/18640
  # tla-plus = callPackage pkgs/tla-plus {};

  # https://github.com/NixOS/nixpkgs/issues/18640
  isabelle2011-1 = callPackage pkgs/isabelle2011-1 {
    inherit (pkgs) stdenv fetchurl nettools perl;
    inherit (pkgs.emacs24Packages) proofgeneral;
    polyml = pkgs.polyml_5_4;
  };

  stellar-core = callPackage pkgs/stellar-core {};
  stellar-horizon = callPackage pkgs/stellar-horizon {};

  chain-core = callPackage pkgs/chain-core {};

  latex = texlive.combine {
    inherit (texlive) scheme-medium mathabx-type1 latexmk;
  };

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
