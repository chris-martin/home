{ ... }:
{
  #services.xserver.libinput.minSpeed = "0.2";
  #services.xserver.libinput.maxSpeed = "0.8";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.accelSpeed = "0.01";
  services.xserver.libinput.touchpad.tapping = false;
  services.xserver.libinput.touchpad.scrollMethod = "twofinger";
  services.xserver.libinput.touchpad.naturalScrolling = false;
  services.xserver.libinput.touchpad.horizontalScrolling = true;
}
