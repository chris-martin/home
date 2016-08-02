let

config = rec {
  home = builtins.getEnv "HOME";
  hostName = builtins.getEnv "HOSTNAME";

  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
    enableWideVine = true;
  };

  # This doesn't work: https://github.com/NixOS/nixpkgs/issues/17457
  truecrypt.wxGUI = false;

  packageOverrides = pkgs: let
    pkgsWithOverrides = pkgs // overrides;
    callEnv = path: import path {
      inherit config;
      pkgs = pkgsWithOverrides;
    };
    overrides = (with pkgs; rec {

      desktopEnv = callEnv ./envs/desktop.nix;
      serverEnv = callEnv ./envs/server.nix;

      # truecrypt refactor work-in-progress
      #truecrypt = with unstable; callPackage pkgs/truecrypt {
      #  stdenv = overrideInStdenv stdenv [ useOldCXXAbi ];
      #};

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

      dummy-wget = callPackage pkgs/dummy-wget {};

      # Pandora probably won't ever be packaged like this in nixpkgs
      pandora = callPackage ./pkgs/pandora {};

      sublime = unstable.sublime3;

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

      # npm2nix is broken everywhere, but seems slightly better in unstable
      npm2nix = unstable.nodePackages.npm2nix;

      # StartupWMClass fix not backported to 16.03
      # https://github.com/NixOS/nixpkgs/pull/15685
      idea = unstable.idea;

      # New thing that probably deserves a PR
      libscrypt = callPackage pkgs/libscrypt { };

      # https://github.com/NixOS/nixpkgs/pull/15979
      secp256k1 = callPackage pkgs/secp256k1 {};

      # https://github.com/NixOS/nixpkgs/pull/15977
      serpent = callPackage pkgs/serpent {};

      # TLA+
      tla-plus = callPackage pkgs/tla-plus {};

      # My software that lives in this repo
      choose = callPackage pkgs/choose {};
      wordlist = callPackage pkgs/wordlist {};
      nix-shell-wrapper = callPackage pkgs/nix-shell-wrapper {};

      # BigchainDB requires rethinkdb version higher than what's in 16.03
      rethinkdb = unstable.rethinkdb;

      isabelle2011-1 = callPackage pkgs/isabelle2011-1 {
        inherit (pkgs) stdenv fetchurl nettools perl;
        inherit (pkgs.emacs24Packages) proofgeneral;
      };

      polyml-5-4 = callPackage pkgs/polyml-5-4 {};

      # Fall back to unstable for Haskell LTS releases that aren't in stable
      haskell = pkgs.haskell // {

        # https://github.com/NixOS/nixpkgs/issues/16629
        compiler = pkgs.haskell.compiler // { ghc801 = unstable.haskell.compiler.ghc801; };

        packages = unstable.haskell.packages // pkgs.haskell.packages;
      };

    }) //

    # Convenience aliases

    (with pkgsWithOverrides.xorg; {
      inherit xkill;
    }) //

    (with pkgsWithOverrides.python27Packages; {
      docker-compose = docker_compose;
    }) //

    (with pkgsWithOverrides.python34Packages; {
      inherit ipython;
    }) //

    (with pkgsWithOverrides.myPython34Packages; {
      inherit bigchaindb pyethereum;
    }) //

    (with pkgsWithOverrides.kde4; {
      inherit kcolorchooser konversation;
    }) //

    (with pkgsWithOverrides.nodePackages; {
      inherit bower npm;
      grunt = grunt-cli;
    }) //

    (with pkgsWithOverrides.gnome3; {
      inherit cheese eog file-roller gnome-screenshot polari;
    }) //

    (with pkgsWithOverrides.haskellPackages; {
      inherit cabal2nix hlint purescript stack stylish-haskell hasktags pointfree pointful ghc-mod;
      cabal = cabal-install;
    }) //

    # Ethereum work-in-progress
    #
    # I think we just need unstable here to get gcc49; we may be
    # able to do with with an explicit dependency instead by passing
    # an { stdenv = overrideCC stdenv gcc49; } override on 16.03
    (with unstable; rec {
      ethereum = callPackage ./pkgs/ethereum {
        jsoncpp = jsoncpp-1-7;
        libjson_rpc_cpp = libjson_rpc_cpp-0-6;
        llvm = llvm_38;
      };
      argtable-2 = callPackage ./pkgs/argtable-2 { };
      jsoncpp-1-7 = callPackage ./pkgs/jsoncpp-1.7 { };
      libjson_rpc_cpp-0-6 = callPackage ./pkgs/libjson-rpc-cpp-0.6 {
        argtable = argtable-2;
        jsoncpp = jsoncpp-1-7;
      };
    });

  in overrides;

  locations = {
    lexington = { latitude = "38.062373"; longitude = "-84.50178"; };
    sanMateo = { latitude = "37.56"; longitude = "-122.33"; };
    atlanta = { latitude = "33.784190"; longitude = "-84.374263"; };
  };
};

unstable = (import <nixpkgs-unstable> { config = { allowUnfree = true; }; });

in config
