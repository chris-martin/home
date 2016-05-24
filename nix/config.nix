let config = rec {
  home = builtins.getEnv "HOME";
  hostName = builtins.getEnv "HOSTNAME";

  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
    enableWideVine = true;
  };

  packageOverrides = pkgs:
    let callEnv = path: import path { inherit config pkgs; }; in
    {
      desktopEnv = callEnv ./envs/desktop.nix;
      serverEnv = callEnv ./envs/server.nix;
    };
};
in config
