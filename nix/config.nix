let config = rec {
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

      pandora = pkgs.callPackage ./pkgs/pandora {};

      # Convenience aliases
      bower = nodePackages.bower;
      grunt = nodePackages.bower;
      ipython = pythonPackages.ipython;
      kcolorchooser = kde4.kcolorchooser;
      konversation = kde4.konversation;
      npm = nodePackages.npm;
      polari = gnome3.polari;

      # Packages that aren't in stable release yet
      gore = (import <nixpkgs-unstable> {}).goPackages.gore;

    };
  in overrides;
};
in config
