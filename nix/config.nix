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

  packageOverrides = pkgs: let
    callEnv = path: import path {
      inherit config;
      pkgs = (pkgs // overrides);
    };
    overrides = (with pkgs; rec {

      desktopEnv = callEnv ./envs/desktop.nix;
      serverEnv = callEnv ./envs/server.nix;

      # Python packages is its own separate bucket of overrides
      pythonPackages = pkgs.pythonPackages // (import pkgs/python-packages.nix pkgs);

      # Pandora probably won't ever be packaged like this in nixpkgs
      pandora = callPackage ./pkgs/pandora {};

      # Sublime with desktop entry: https://github.com/NixOS/nixpkgs/pull/15710
      sublime = unstable.callPackage ./pkgs/sublime {};

      # App engine init: https://github.com/NixOS/nixpkgs/pull/14237
      google-app-engine-sdk = callPackage ./pkgs/google-app-engine-sdk {};

      # Gore isn't backported to 16.03
      gore = unstable.goPackages.gore;

      # geth alias will be in unstable after https://github.com/NixOS/nixpkgs/pull/15702
      geth = unstable.goPackages.ethereum.bin // { outputs = [ "bin" ]; };

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

      wordlist = callPackage pkgs/wordlist {};

    }) //

    # Convenience aliases

    (with pkgs.xorg; {
      inherit xkill;
    }) //

    (with pkgs.pythonPackages; {
      inherit ipython;
      docker-compose = docker_compose;
    }) //

    (with pkgs.kde4; {
      inherit kcolorchooser konversation;
    }) //

    (with pkgs.nodePackages; {
      inherit bower npm;
      grunt = grunt-cli;
    }) //

    (with pkgs.gnome3; {
      inherit cheese eog file-roller gnome-screenshot polari;
    }) //

    (with pkgs.haskellPackages; {
      inherit cabal2nix purescript stack stylish-haskell;
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
