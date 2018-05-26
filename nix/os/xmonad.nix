{
  services.xserver.windowManager.xmonad = {
    enable = true;
    extraPackages = haskellPackages: with haskellPackages; [
      xmonad-contrib xmonad-extras
    ];
  };

  # https://twitter.com/ttuegel/status/997561239659270145
  environment.pathsToLink = [ "/share" ];
}
