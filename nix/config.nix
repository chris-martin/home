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

  # This doesn't work: https://github.com/NixOS/nixpkgs/issues/17457
  #truecrypt.wxGUI = false;

  packageOverrides = pkgs: import ./overrides.nix {
    inherit pkgs config unstable;
  };

  locations = {
    lexington = { latitude = "38.062373"; longitude = "-84.50178"; };
    sanMateo = { latitude = "37.56"; longitude = "-122.33"; };
    atlanta = { latitude = "33.784190"; longitude = "-84.374263"; };
  };
};

unstable = (import <nixpkgs-unstable> { config = { allowUnfree = true; }; });

in config
