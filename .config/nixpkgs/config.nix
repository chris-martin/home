let

  # all of the configuration except the package overrides
  config-without-overrides = {
    allowUnfree = true;
  };

  # slightly more convenient aliases for packages defined in nixpkgs
  aliases = pkgs:
    {
      inherit (pkgs.gnome3) cheese;
      inherit (pkgs.gnome3) eog;
      inherit (pkgs.gnome3) file-roller;
      inherit (pkgs.gnome3) gnome-screenshot;
      inherit (pkgs.gnome3) nautilus;
      inherit (pkgs.gnome3) totem;
      inherit (pkgs.xorg) xkill;
    };

  haskell-apps = pkgs:
    let
      package-names = [
        "cabal-bounds"
        "doctest"
        "FractalArt"
        "ghcid"
        "hfmt"
        "hoogle"
        "hindent"
        "hlint"
        "hpack"
        "sws"
      ];
      f = x: {
        name = x;
        value =
                  pkgs.haskellPackages.${x};
      };
    in
      builtins.listToAttrs (builtins.map f package-names);

  # the packages that we cherry-pick from the 'unstable' channel
  from-unstable = pkgs: {
    inherit (unstable)
      ghc
      obs-studio
      stack
      sws
      vscode
      wezterm
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
    { packageOverrides = package-overrides;
      android_sdk.accept_license = true;
    };

  # the package overrides for the 'unstable' channel
  unstable-package-overrides = pkgs:
    aliases pkgs //
    haskell-apps pkgs;

  # the nixpkgs configuration we use to instantiate the package set from the 'unstable' channel
  config-for-unstable =
    config-without-overrides //
    { packageOverrides = unstable-package-overrides; };

  # the package set from the 'unstable' channel
  unstable = import <nixpkgs-unstable> { config = config-for-unstable; };

in config
