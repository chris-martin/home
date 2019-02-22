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
    acherus-militant = pkgs.callPackage ./pkgs/acherus-militant { };
    ede = pkgs.callPackages ./pkgs/ede { };
    fullwidth = pkgs.callPackage ./pkgs/fullwidth { };
    haskell-ci = pkgs.haskell.lib.justStaticExecutables
      (pkgs.haskellPackages.callPackage ./pkgs/haskell-ci/haskell-ci.nix { });
    jetrix = pkgs.callPackage ./pkgs/jetrix { };
    my-xmonad = pkgs.callPackage ./pkgs/my-xmonad { };
    pandora = pkgs.callPackage ./pkgs/pandora { };
    rip-cd = pkgs.callPackage ./pkgs/rip-cd { };
    rollandin-emilie = pkgs.callPackage ./pkgs/rollandin-emilie { };
    slack-latex = pkgs.callPackage ./pkgs/slack-latex { };
    stylish-haskell = pkgs.callPackage ./pkgs/stylish-haskell { };
    tetrinetx = pkgs.callPackage ./pkgs/tetrinetx { };
    text-replace = pkgs.callPackage ./pkgs/text-replace { };
    wordlist = pkgs.callPackage ./pkgs/wordlist { };
    yi-chris-martin = pkgs.haskell.lib.justStaticExecutables
      (pkgs.haskellPackages.callPackage ../yi/yi.nix { });
  };

  # slightly more convenient aliases for packages defined in nixpkgs
  aliases = pkgs:
    {
      inherit (pkgs.gnome3) cheese;
      inherit (pkgs.gnome3) eog;
      inherit (pkgs.gnome3) file-roller;
      inherit (pkgs.python27Packages) glances;
      inherit (pkgs.gnome3) gnome-screenshot;
      inherit (pkgs.gnome3) gnome-terminal;
      intellij = pkgs.jetbrains.idea-community;
      inherit (pkgs.gnome3) nautilus;
      inherit (pkgs.gnome3) totem;
      inherit (pkgs.xorg) xkill;
    };

  haskell-apps = pkgs:
    let
      package-names = [
        "choose-exe"
        "doctest"
        "FractalArt"
        "ghcid"
        "hoogle"
        "hindent"
        "nix-deploy"
        "pandoc-sidenote"
        "sws"
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
      #cabal2nix
      #doctest
      #firefox
      #ghc
      #ghcid
      #gtetrinet
      haskell-ci
      #intellij
      #nix-deploy
      #nixUnstable
      #nodePackages
      obs-studio
      #secp256k1
      stack
      #stack2nix
      #steam
      #stylish-haskell
      ;
    #haskell-ci = unstable.haskell.lib.justStaticExecutables
    #  unstable.haskellPackages.haskell-ci;
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
  unstable = import <nixpkgs-unstable> { config = config-for-unstable; };

in config
