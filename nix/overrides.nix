{ pkgs, config, unstable, master }:
let

pkgsWithOverrides = pkgs // overrides;

callEnv = path: import path {
  inherit config;
  pkgs = pkgsWithOverrides;
};

overrides = (with pkgs; rec {

  desktopEnv = callEnv ./desktopEnv.nix;

  inherit (master) secp256k1 gtetrinet tetrinetx jetrix;

  inherit (unstable) stack jetbrains nodePackages;

  # workaround for https://github.com/NixOS/nixpkgs/issues/25880
  #inherit (unstable) google-chrome;

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

  # App engine init: https://github.com/NixOS/nixpkgs/pull/14237
  google-app-engine-sdk = callPackage ./pkgs/google-app-engine-sdk {};

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

});

in overrides
