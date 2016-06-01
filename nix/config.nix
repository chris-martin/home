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
      libscrypt = callPackage ./pkgs/libscrypt { };

      py-cryptodome = pythonPackages.buildPythonPackage rec {
        name = "pycryptodome-3.4";

        src = fetchurl {
          url = "https://pypi.python.org/packages/78/a9/3ad761efa8c947d06db18a4a7cfc7773806cdee48a37187b022647313d68/${name}.tar.gz";
          sha256 = "0nc4ry2ah56l40hr1dilw19ksma8bx3cmn99mp5vml4jlz9zkg16";
        };
      };

      py-sha3 = pythonPackages.buildPythonPackage rec {
        name = "pysha3-0.1";

        src = fetchurl {
          url = "https://pypi.python.org/packages/89/6a/fe37f6f74acee78c20cfa9206a39e09503514aa70ceb67b6fd0af4327089/${name}.tar.gz";
          sha256 = "1zhkj2wp019amvq9hqwcsmdj4lxgzhdab78ydchag4k3d8vhkq9n";
        };

        meta = {
          homepage = https://bitbucket.org/tiran/pykeccak;
          description = "SHA-3 wrapper (keccak) for Python";
        };
      };

      py-rlp = py-rlp-0-4-5;

      py-rlp-0-4-5 = pythonPackages.buildPythonPackage rec {
        name = "rlp-${version}";
        version = "0.4.5";

        src = fetchurl {
          url = "https://pypi.python.org/packages/91/68/01756d0e57f4d2ad151c277b838256c58ffc1a0f97812f265f17563a5765/${name}.tar.gz";
          sha256 = "14vp35w1fkavnv17qgfz5mfa3k5l3przj4gvlma3r8f9hqwbjwrw";
        };
      };

      py-rlp-0-4-4 = pythonPackages.buildPythonPackage rec {
        name = "rlp-${version}";
        version = "0.4.4";

        src = fetchurl {
          url = "https://pypi.python.org/packages/9a/e9/003c57e947097b855af81ba9ec1a41e1daf3aec921073aa4516e0a00a246/${name}.tar.gz";
          sha256 = "0ca3fqz7pgd8wmm8mgqlfz56l94x375w2wmgkbg26h624nk0bkdd";
        };
      };

      secp256k1 = stdenv.mkDerivation rec {
        name = "secp256k1";

        src = fetchFromGitHub {
          owner = "bitcoin-core";
          repo = "secp256k1";
          rev = "b3be8521e694eaf45dd29baea035055183c42fe2";
          sha256 = "1pgsy72w87yxbiqn96hnm8alsfx3rj7d9jlzdsypyf6i1rf6w4bq";
        };

        buildInputs = [ autoconf automake libtool ];

        configureFlags = [ "--enable-module-recovery" ];

        preConfigure = "./autogen.sh";

        # The python wrapper requires autogen.sh to be there
        postInstall = "cp autogen.sh $out/lib";
      };

      py-secp256k1 = pythonPackages.buildPythonPackage rec {
        name = "secp256k1";

        src = fetchFromGitHub {
          owner = "ulope";
          repo = "secp256k1-py";
          rev = "cb3078d4800ac0bdc64f4242462cb3c186329378";
          sha256 = "0kyaph97gjwv4vv5nl9j5w8zp2bb606z4hfmjzl5la1da5gsdfaq";
        };

        buildInputs = [ pkgconfig ];
        propagatedBuildInputs = [ pythonPackages.cffi secp256k1 ];

        preConfigure = ''
          ln -s ${secp256k1.src} libsecp256k1
          export INCLUDE_DIR=${secp256k1}/include
          export LIB_DIR=${secp256k1}/lib
        '';

        meta = {
          homepage = https://github.com/ulope/secp256k1-py;
          description = "Python FFI bindings for secp256k1";
        };
      };

      py-bitcoin = pythonPackages.buildPythonPackage rec {
        name = "bitcoin-${version}";
        version = "1.1.42";

        src = fetchurl {
          url = "https://pypi.python.org/packages/12/88/c9390638d5b2713d38ccea46c93e8ec084f052a15a94f9b1d4c66baabd24/${name}.tar.gz";
          sha256 = "0dkjifd8d60an0jl6k9zqx9r0p5xprzlrgf4n9mlyxhwksyp1fhi";
        };
      };

      # broken
      py-scrypt-0-7-1 = pythonPackages.buildPythonPackage rec {
        name = "scrypt-${version}";
        version = "0.7.1";

        src = fetchurl {
          url = "https://pypi.python.org/packages/f6/fa/2e80258d58555d38ba0373db3c8947e03ceaaa91ad9f80725802bc05aa77/${name}.tar.gz";
          sha256 = "18qxyqh0r5p3iyx3g6yd3vmmnw3yl1qz0cb59cw7hqc11hq8rxpm";
        };

        propagatedBuildInputs = [ openssl ];
      };

      py-scrypt-0-7-0 = pythonPackages.buildPythonPackage rec {
        name = "scrypt-${version}";
        version = "0.7.0";

        src = fetchurl {
          url = "https://pypi.python.org/packages/47/6d/43520bedaac7c5c2b2a9e5a8229d82ca2c2242c34b46575ed7b988f248a5/${name}.tar.gz";
          sha256 = "0vx579w6ik9l46bh41piq9bf49aa3xhzh768lz59qxvh6z6xmhx5";
        };

        propagatedBuildInputs = [ openssl ];
      };

      py-scrypt = py-scrypt-0-7-0;

      pytest = pytest-2-9-1;

      # Pytest upgraded beyond what's in nixpkgs upstream.
      # There's some stuff removed from this definition that
      # I just didn't care about.
      pytest-2-9-1 = buildPythonPackage rec {
        name = "pytest-2.9.1";

        src = pkgs.fetchurl {
          url = "https://pypi.python.org/packages/5e/f0/75c5cee17575bef459c916b6276bd9ad56944836bb0d9e36dd05704e7f35/${name}.tar.gz";
          sha256 = "0rby2jlb67mrjkv6siyl8m82by1migh5g08mr3kzni3n29xd4j0d";
        };

        preCheck = ''
          # don't test bash builtins
          rm testing/test_argcomplete.py
        '';

        propagatedBuildInputs = [ pythonPackages.py ];
      };

      pytest-catchlog = pythonPackages.buildPythonPackage rec {
        name = "pytest-catchlog-1.2.2";

        src = fetchurl {
          url = "https://pypi.python.org/packages/f2/2b/2faccdb1a978fab9dd0bf31cca9f6847fbe9184a0bdcc3011ac41dd44191/${name}.zip";
          sha256 = "1w7wxh27sbqwm4jgwrjr9c2gy384aca5jzw9c0wzhl0pmk2mvqab";
        };

        propagatedBuildInputs = [ pythonPackages.py pytest ];
      };

      pytest-timeout = pythonPackages.buildPythonPackage rec {
        name = "pytest-timeout-1.0.0";

        src = fetchurl {
          url = "https://pypi.python.org/packages/cf/92/ab29b9baa54d47dfd50e43be35577de9af4e7ebf27d29f546ddeb6c3b6f5/${name}.tar.gz";
          sha256 = "1qccg490vvjsasy5dmwpp4apx2j2j8v4bcfi2lgdy5iywxmhjr8l";
        };

        propagatedBuildInputs = [ pythonPackages.py pytest ];
      };

      ethereum-serpent = stdenv.mkDerivation rec {
        name = "ethereum-serpent";
        src = fetchFromGitHub {
          owner = "ethereum";
          repo = "serpent";
          rev = "51ee60857fe53c871fa916ef66fc1b4255bb9433";
          sha256 = "1bns9wgn5i1ahj19qx7v1wwdy8ca3q3pigxwznm5nywsw7s7lqxs";
        };
        installPhase = ''
          mkdir -p $out/bin
          mv serpent $out/bin
        '';
      };

      py-ethereum-serpent = pythonPackages.buildPythonPackage rec {
        name = "ethereum-serpent";
        src = fetchFromGitHub {
          owner = "ethereum";
          repo = "serpent";
          rev = "51ee60857fe53c871fa916ef66fc1b4255bb9433";
          sha256 = "1bns9wgn5i1ahj19qx7v1wwdy8ca3q3pigxwznm5nywsw7s7lqxs";
        };
      };

      py-coveralls = pythonPackages.buildPythonPackage rec {
        name = "coveralls-1.1";

        src = fetchurl {
          url = "https://pypi.python.org/packages/12/50/5c1034eb92e5bc3d824a3745ca9162f2e4846c6ab5f96dccb5f84f77e98f/${name}.tar.gz";
          sha256 = "0238hgdwbvriqxrj22zwh0rbxnhh9c6hh75i39ll631vq62h65il";
        };

        propagatedBuildInputs = [
          pythonPackages.docopt
          pythonPackages.coverage
          pythonPackages.requests
          pythonPackages.pyyaml
        ];
      };

      py-ethash = pythonPackages.buildPythonPackage rec {
        name = "pyethash-0.1.27";
        src = fetchurl {
          url = "https://pypi.python.org/packages/6c/40/5bb02ad7e2fae9b04cd0c391dda81213bc786c30c8381b018600cfc7ce62/${name}.tar.gz";
          sha256 = "0618kkn2sb0a3h2pphpj2vi455xc9mil42b13zgpg7bbwaf32rpz";
        };
      };

      py-ethereum = pythonPackages.buildPythonPackage rec {
        version = "1.3.2";
        name = "pyethereum-${version}";

        src = fetchgit {
          url = "https://github.com/ethereum/pyethereum.git";
          rev = "refs/tags/v${version}";
          sha256 = "0bzqppjyy6ppgcbql416vyy1ylgq9ic1lpsa5004995hn539jf8q";
          fetchSubmodules = true;
        };

        checkPhase = ''
          echo "Skipping pyethereum tests because they're slow."
        '';

        buildInputs = [
          pytest-2-9-1
          pytest-catchlog
          pytest-timeout
          py-ethereum-serpent
          py-coveralls
          pythonPackages.tox
          pythonPackages.virtualenv
          pythonPackages.pluggy
        ];

        propagatedBuildInputs = [
          py-bitcoin
          py-sha3
          pythonPackages.pyyaml
          pythonPackages.repoze_lru
          pythonPackages.pbkdf2
          py-cryptodome
          py-scrypt
          py-rlp-0-4-4
          py-ethash
          py-secp256k1
        ];

        meta = {
          homepage = https://github.com/ethereum/pyethereum;
          description = "Next generation cryptocurrency network";
        };
      };

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
      inherit eog file-roller gnome-screenshot polari;
    }) //

    (with pkgs.haskellPackages; {
      inherit cabal2nix stack stylish-haskell;
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
