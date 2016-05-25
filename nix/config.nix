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

      # Packages that aren't and probably won't ever be in nixpkgs
      pandora = callPackage ./pkgs/pandora {};

      # Convenience aliases
      bower = nodePackages.bower;
      cabal = haskellPackages.cabal-install;
      cabal2nix = haskellPackages.cabal2nix;
      docker-compose = pythonPackages.docker_compose;
      eog = gnome3.eog;
      file-roller = gnome3.file-roller;
      gnome-screenshot = gnome3.gnome-screenshot;
      grunt = nodePackages.bower;
      ipython = pythonPackages.ipython;
      kcolorchooser = kde4.kcolorchooser;
      konversation = kde4.konversation;
      npm = nodePackages.npm;
      polari = gnome3.polari;
      stack = haskellPackages.stack;
      stylish-haskell = haskellPackages.stylish-haskell;
      xkill = xorg.xkill;

      # Packages that aren't in stable release yet
      gore = unstable.goPackages.gore;

      # https://github.com/NixOS/nixpkgs/pull/15702
      geth = unstable.goPackages.ethereum.bin // { outputs = [ "bin" ]; };

      # npm2nix is broken everywhere, but seems slightly better in unstable
      npm2nix = unstable.nodePackages.npm2nix;

    };
  in overrides;

  locations = {
    lexington = { latitude = "38.062373"; longitude = "-84.50178"; };
    sanMateo = { latitude = "37.56"; longitude = "-122.33"; };
    atlanta = { latitude = "33.784190"; longitude = "-84.374263"; };
  };
};

unstable = (import <nixpkgs-unstable> { config = { allowUnfree = true; }; });

in config
