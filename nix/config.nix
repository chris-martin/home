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

      pandora = callPackage ./pkgs/pandora {};

      # Convenience aliases
      bower = nodePackages.bower;
      grunt = nodePackages.bower;
      ipython = pythonPackages.ipython;
      kcolorchooser = kde4.kcolorchooser;
      konversation = kde4.konversation;
      npm = nodePackages.npm;
      polari = gnome3.polari;

      # Packages that aren't in stable release yet
      gore = unstable.goPackages.gore;
      geth = unstable.goPackages.ethereum;

    };
  in overrides;

  locations = {
    lexington = { latitude = "38.062373"; longitude = "-84.50178"; };
    sanMateo = { latitude = "37.56"; longitude = "-122.33"; };
    atlanta = { latitude = "33.784190"; longitude = "-84.374263"; };
  };
};

unstable = (import <nixpkgs-unstable> {});

in config
