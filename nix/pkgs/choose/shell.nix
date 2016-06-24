{ nixpkgs ? import <nixpkgs> {} }:

(nixpkgs.callPackage ./. {}).env
