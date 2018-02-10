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
    slack-latex = pkgs.callPackage ./pkgs/slack-latex { };
    tetrinetx = pkgs.callPackage ./pkgs/tetrinetx { };
    text-replace = pkgs.callPackage ./pkgs/text-replace { };
    wordlist = pkgs.callPackage ./pkgs/wordlist { };
  };

  # slightly more convenient aliases for packages defined in nixpkgs
  aliases = pkgs:
    {
      inherit (pkgs.gnome3) cheese;
      inherit (pkgs.gnome3) eog;
      inherit (pkgs.gnome3) file-roller;
      inherit (pkgs.python27Packages) glances;
      inherit (pkgs.gnome3) gnome-screenshot;
      intellij = pkgs.jetbrains.idea-community;
      inherit (pkgs.xorg) xkill;
    };

  haskell-apps = pkgs:
    let
      package-names = [
        "choose-exe"
        "doctest"
        "ghcid"
        "hoogle"
        "hindent"
        "nix-deploy"
        "pandoc-sidenote"
        "stylish-haskell"
      ];
      f = x: {
        name = x;
        value = pkgs.haskell.lib.justStaticExecutables
                  pkgs.haskellPackages.${x};
      };
    in
      builtins.listToAttrs (builtins.map f package-names);

  # the packages that we cherry-pick from the 'unstable' channel
  from-unstable = pkgs: {
    inherit (unstable)
      cabal-install
      cabal2nix
      firefox
      ghc
      gtetrinet
      intellij
      nix-deploy
      nodePackages
      secp256k1
      stack2nix
      yi
      ;
  };

  # all of the package overrides
  package-overrides = pkgs:
    unstable-package-overrides pkgs //
    from-unstable pkgs //
    { nixpkgs-unstable = unstable; };

  # the full nixpkgs configuration
  config =
    config-without-overrides //
    { packageOverrides = package-overrides; };

  # the package overrides for the 'unstable' channel
  unstable-package-overrides = pkgs:
    new-packages pkgs //
    aliases pkgs //
    haskell-apps pkgs;

  # the nixpkgs configuration we use to instantiate the package set from the 'unstable' channel
  config-for-unstable =
    config-without-overrides //
    { packageOverrides = unstable-package-overrides; };

  # the package set from the 'unstable' channel
  unstable = import <unstable> { config = config-for-unstable; };

in config
