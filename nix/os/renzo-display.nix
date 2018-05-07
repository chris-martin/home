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

  services.xserver.displayManager.sessionCommands = ''
    dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font "'Monospace 12'"
    dconf write /org/gnome/desktop/interface/font-name "'Cantarell 13'"
    dconf write /org/gnome/desktop/interface/document-font-name "'Lato Medium 13'"
    dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'Lato Bold 13'"
  '';
}
