let

home = builtins.getEnv "HOME";

simple-config = {

  inherit home;
  hostName = builtins.getEnv "HOSTNAME";

  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
    enableWideVine = true;
  };
};

config = simple-config // {
  packageOverrides = pkgs: import ./overrides.nix {
    inherit pkgs config unstable master;
  };
};

unstable = (import <unstable> { config = simple-config; });

master = (import <master> { config = simple-config; });

in config
