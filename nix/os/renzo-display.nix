{ ... }:
{
  services.xserver.enable = true;

  #services.xserver.desktopManager.gnome3.enable = true;
  #services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.plasma5.enable = true;

  #services.xserver.desktopManager.default = "none";
  services.xserver.displayManager.slim.enable = true;
  #services.xserver.windowManager.xmonad.enable = true;
  #services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  #services.xserver.windowManager.default = "openbox";

  #services.xserver.windowManager.openbox.enable = true;

  #services.xserver.windowManager = {
  #  session = [{
  #    name = "xmonad";
  #    start = ''
  #      my-xmonad &
  #      waitPID=$!
  #    '';
  #  }];
  #};
}
