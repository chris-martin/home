{ ... }:
{
  services.xserver.enable = true;

  services.xserver.desktopManager.gnome3.enable = true;

  #services.xserver.desktopManager.default = "none";

  #services.xserver.desktopManager.xterm.enable = false;

  #services.xserver.windowManager.default = "xmonad";

  services.xserver.windowManager.xmonad = {
    #enable = true;
    extraPackages = haskellPackages: with haskellPackages; [
      xmonad-contrib xmonad-extras
    ];
  };
}
