let

  # all of the configuration except the package overrides
  config-without-overrides = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
      enableWideVine = true;
    };
  };

  # packages defined locally that aren't in nixpkgs
  new-packages = pkgs: {
    desktop-env = pkgs.callPackage ./pkgs/desktop-env { };
    fullwidth = pkgs.callPackage ./pkgs/fullwidth { };
    jetrix = pkgs.callPackage ./pkgs/jetrix { };
    pandora = pkgs.callPackage ./pkgs/pandora { };
    tetrinetx = pkgs.callPackage ./pkgs/tetrinetx { };
    text-replace = pkgs.callPackage ./pkgs/text-replace { };
    wordlist = pkgs.callPackage ./pkgs/wordlist { };
  };

  # slightly more convenient aliases for packages defined in nixpkgs
  aliases = pkgs:
    let
      haskell-app = name:
        pkgs.haskell.lib.justStaticExecutables pkgs.haskellPackages.${name};
    in {
      choose = haskell-app "choose";
      inherit (pkgs.gnome3) cheese;
      doctest = haskell-app "doctest";
      inherit (pkgs.gnome3) eog;
      inherit (pkgs.gnome3) file-roller;
      inherit (pkgs.python27Packages) glances;
      inherit (pkgs.gnome3) gnome-screenshot;
      intellij = pkgs.jetbrains.idea-community;
      nix-deploy = haskell-app "nix-deploy";
      stylish-haskell = haskell-app "stylish-haskell";
      inherit (pkgs.xorg) xkill;
    };

  # the packages that we cherry-pick from the 'unstable' channel
  from-unstable = pkgs: {
    inherit (unstable)
      cabal2nix
      firefox
      gtetrinet
      intellij
      nix-deploy
      nodePackages
      secp256k1
      ;
  };

  # all of the package overrides
  package-overrides = pkgs:
    new-packages pkgs //
    aliases pkgs //
    from-unstable pkgs //
    { nixpkgs-unstable = unstable; };

  # the full nixpkgs configuration
  config =
    config-without-overrides //
    { packageOverrides = package-overrides; };

  # the package overrides for the 'unstable' channel
  unstable-package-overrides = pkgs:
    new-packages pkgs //
    aliases pkgs;

  # the nixpkgs configuration we use to instantiate the package set from the 'unstable' channel
  config-for-unstable =
    config-without-overrides //
    { packageOverrides = unstable-package-overrides; };

  # the package set from the 'unstable' channel
  unstable = import <unstable> { config = config-for-unstable; };

in config
