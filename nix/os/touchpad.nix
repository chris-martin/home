{ ... }:
{
  #services.xserver.libinput.minSpeed = "0.2";
  #services.xserver.libinput.maxSpeed = "0.8";

  services.xserver.libinput.enable = true;
  services.xserver.libinput.accelSpeed = "0.01";
  services.xserver.libinput.tapping = false;
  services.xserver.libinput.scrollMethod = "twofinger";
  services.xserver.libinput.naturalScrolling = false;
  services.xserver.libinput.horizontalScrolling = true;
}
