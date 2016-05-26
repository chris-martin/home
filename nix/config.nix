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
    overrides = with pkgs; {

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

    } //

    # Convenience aliases

    (with xorg; {
      inherit xkill;
    }) //

    (with pythonPackages; {
      inherit ipython;
      docker-compose = docker_compose;
    }) //

    (with kde4; {
      inherit kcolorchooser konversation;
    }) //

    (with nodePackages; {
      inherit bower npm;
      grunt = grunt-cli;
    }) //

    (with gnome3; {
      inherit eog file-roller gnome-screenshot polari;
    }) //

    (with haskellPackages; {
      inherit cabal2nix stack stylish-haskell;
      cabal = cabal-install;
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
