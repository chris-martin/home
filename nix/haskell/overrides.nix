
self: super: {

aeson-optics = self.callPackage (
    { mkDerivation, aeson, attoparsec, base, base-compat, bytestring
    , optics-core, optics-extra, scientific, stdenv, text
    , unordered-containers, vector, Cabal, cabal-doctest
    }:
    mkDerivation {
      pname = "aeson-optics";
      version = "1.1";
      sha256 = "a8790affbdf061149ebf0d5cf41d86ff4892c0ec21e244dc8101ffa027a4d033";
      revision = "1";
      editedCabalFile = "1ql2zqjcwy744qzydj3gk4qgnj4nzba6j2d5fvi31i5va7vqad2d";
      setupHaskellDepends = [ base Cabal cabal-doctest ];
      libraryHaskellDepends = [
        aeson attoparsec base base-compat bytestring optics-core
        optics-extra scientific text unordered-containers vector
      ];
      homepage = "http://github.com/phadej/aeson-optics";
      description = "Law-abiding optics for aeson";
      license = stdenv.lib.licenses.mit;
    }
) {};

grab = self.callPackage (
    { mkDerivation, base, criterion, hedgehog, stdenv }:
    mkDerivation {
      pname = "grab";
      version = "0.0.0.4";
      sha256 = "44ca2087a4a20d400cc59759d78fca7a946710f894d264b931826b3155aa5679";
      libraryHaskellDepends = [ base ];
      testHaskellDepends = [ base hedgehog ];
      benchmarkHaskellDepends = [ base criterion ];
      homepage = "https://github.com/typeclasses/grab";
      description = "Applicative non-linear consumption";
      license = stdenv.lib.licenses.mit;
    }
) {};

grab-form = self.callPackage (
    { mkDerivation, base, containers, grab, hedgehog, stdenv, text }:
    mkDerivation {
      pname = "grab-form";
      version = "0.0.0.4";
      sha256 = "c59605b2f367bbc1324261d518cccdd6ef0ae511d9f74c63d0c94fe926600832";
      libraryHaskellDepends = [ base containers grab text ];
      testHaskellDepends = [ base containers hedgehog text ];
      homepage = "https://github.com/typeclasses/grab";
      description = "Applicative parsers for form parameter lists";
      license = stdenv.lib.licenses.mit;
    }
) {};

hs-nix-modules = self.callPackage (
    { mkDerivation, base, containers, directory, fetchgit, filepath
    , haskell-src-exts, optparse-applicative, pipes, stdenv, text
    }:
    mkDerivation {
      pname = "hs-nix-modules";
      version = "0";
      src = fetchgit {
        url = "https://github.com/typeclasses/hs-nix-modules.git";
        sha256 = "0vq1b6nd1rds3iv7xm8891q2z4sc8hxwhwvwchf96bzqh6zi6ksx";
        rev = "5c7cb693c3121b41d46aa28f16209d0b4be1e4f7";
        fetchSubmodules = true;
      };
      postUnpack = "sourceRoot+=/hs-nix-modules; echo source root reset to $sourceRoot";
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [
        base containers directory filepath haskell-src-exts
        optparse-applicative pipes text
      ];
      license = "unknown";
      hydraPlatforms = stdenv.lib.platforms.none;
    }
) {};

optics = self.callPackage (
    { mkDerivation, array, base, bytestring, containers, criterion
    , inspection-testing, lens, mtl, optics-core, optics-extra
    , optics-th, random, stdenv, tasty, tasty-hunit, template-haskell
    , transformers, unordered-containers, vector
    }:
    mkDerivation {
      pname = "optics";
      version = "0.1";
      sha256 = "930a8c4ddacb0c4c54755c509ff8732fa830096727eeb00f436e7d08b5676cf6";
      libraryHaskellDepends = [
        array base containers mtl optics-core optics-extra optics-th
        transformers
      ];
      testHaskellDepends = [
        base containers inspection-testing mtl optics-core random tasty
        tasty-hunit template-haskell
      ];
      benchmarkHaskellDepends = [
        base bytestring containers criterion lens transformers
        unordered-containers vector
      ];
      description = "Optics as an abstract interface";
      license = stdenv.lib.licenses.bsd3;
    }
) {};

optics-core = self.callPackage (
    { mkDerivation, array, base, containers, stdenv, transformers }:
    mkDerivation {
      pname = "optics-core";
      version = "0.1";
      sha256 = "011fc8fb4480ddcc1d367ed8a646718e52b9d31617dc9e07501ae88ba9dcdb6f";
      libraryHaskellDepends = [ array base containers transformers ];
      description = "Optics as an abstract interface: core definitions";
      license = stdenv.lib.licenses.bsd3;
    }
) {};

optics-extra = self.callPackage (
    { mkDerivation, array, base, bytestring, containers, hashable, mtl
    , optics-core, stdenv, text, transformers, unordered-containers
    , vector
    }:
    mkDerivation {
      pname = "optics-extra";
      version = "0.1";
      sha256 = "efecc1c4d01908e1086b1cc0a5907d5725b7259273a5ca7ac77ff5976aa70bfc";
      libraryHaskellDepends = [
        array base bytestring containers hashable mtl optics-core text
        transformers unordered-containers vector
      ];
      description = "Extra utilities and instances for optics-core";
      license = stdenv.lib.licenses.bsd3;
    }
) {};

optics-th = self.callPackage (
    { mkDerivation, base, containers, mtl, optics-core, stdenv
    , template-haskell, th-abstraction, transformers
    }:
    mkDerivation {
      pname = "optics-th";
      version = "0.1";
      sha256 = "66de28a58cedb9dfccd43a68dd4a4234254f29fb5edb5d8fe462eed8ceed0abb";
      revision = "1";
      editedCabalFile = "034563mm7rdck8xhwjpqig3kj9rzk91s292rwcargbgbpma5ailv";
      libraryHaskellDepends = [
        base containers mtl optics-core template-haskell th-abstraction
        transformers
      ];
      testHaskellDepends = [ base optics-core ];
      description = "Optics construction using TemplateHaskell";
      license = stdenv.lib.licenses.bsd3;
    }
) {};

stripe-concepts = self.callPackage (
    { mkDerivation, base, bytestring, fetchgit, stdenv, text }:
    mkDerivation {
      pname = "stripe-concepts";
      version = "1.0.2.0";
      src = fetchgit {
        url = "https://github.com/typeclasses/stripe.git";
        sha256 = "02403a6iv0xipvh3nhhzdwajcaa5sh9mdiacwxwm2hdkf7r72fd9";
        rev = "caea9f987101ad2283b0cead73775c1b760fbcaa";
        fetchSubmodules = true;
      };
      postUnpack = "sourceRoot+=/stripe-concepts; echo source root reset to $sourceRoot";
      libraryHaskellDepends = [ base bytestring text ];
      homepage = "https://github.com/typeclasses/stripe";
      description = "Types for the Stripe API";
      license = stdenv.lib.licenses.mit;
    }
) {};

stripe-wreq = self.callPackage (
    { mkDerivation, aeson, base, bytestring, fetchgit, lens, stdenv
    , stripe-concepts, text, unordered-containers, wreq
    }:
    mkDerivation {
      pname = "stripe-wreq";
      version = "1.0.1.0";
      src = fetchgit {
        url = "https://github.com/typeclasses/stripe.git";
        sha256 = "02403a6iv0xipvh3nhhzdwajcaa5sh9mdiacwxwm2hdkf7r72fd9";
        rev = "caea9f987101ad2283b0cead73775c1b760fbcaa";
        fetchSubmodules = true;
      };
      postUnpack = "sourceRoot+=/stripe-wreq; echo source root reset to $sourceRoot";
      libraryHaskellDepends = [
        aeson base bytestring lens stripe-concepts text
        unordered-containers wreq
      ];
      homepage = "https://github.com/typeclasses/stripe";
      description = "Use the Stripe API via Wreq";
      license = stdenv.lib.licenses.mit;
    }
) {};

}
